use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_n_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(sveor_n_s64_x(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_n_s64_x(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_n_s64_x(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_n_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_n_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(sveor_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_s64_z(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_n_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(sveor_n_s64_z(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_n_s64_z(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_n_s64_z(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_n_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_n_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(sveor_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_u8_m(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_n_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(sveor_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_n_u8_m(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_n_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_n_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(sveor_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_u8_x(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_n_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(sveor_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_n_u8_x(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_n_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_n_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(sveor_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_u8_z(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_n_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(sveor_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_n_u8_z(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_n_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_n_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(sveor_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_u16_m(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_n_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(sveor_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_n_u16_m(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_n_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_n_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(sveor_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_u16_x(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_n_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(sveor_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_n_u16_x(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_n_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_n_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(sveor_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_u16_z(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_n_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(sveor_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_n_u16_z(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_n_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_n_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(sveor_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_n_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(sveor_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_n_u32_m(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_n_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_n_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(sveor_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_n_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(sveor_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_n_u32_x(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_n_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_n_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(sveor_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_n_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(sveor_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_n_u32_z(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_n_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_n_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(sveor_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_n_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(sveor_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_n_u64_m(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_n_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_n_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(sveor_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_n_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(sveor_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_n_u64_x(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_n_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_n_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(sveor_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_u64_z(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveor_n_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(sveor_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveor_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor_n_u64_z(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveor_n_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveor_n_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveorv_s8_impl() -> Result<(), String> {
    unsafe {
        let result = sveorv_s8(create_svbool_t(), create_svint8_t_from(2i8));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sveorv_s8(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorv_s8(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveorv_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveorv_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveorv_s16_impl() -> Result<(), String> {
    unsafe {
        let result = sveorv_s16(create_svbool_t(), create_svint16_t_from(2i16));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sveorv_s16(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorv_s16(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveorv_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveorv_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveorv_s32_impl() -> Result<(), String> {
    unsafe {
        let result = sveorv_s32(create_svbool_t(), create_svint32_t_from(2i32));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sveorv_s32(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorv_s32(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveorv_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveorv_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveorv_s64_impl() -> Result<(), String> {
    unsafe {
        let result = sveorv_s64(create_svbool_t(), create_svint64_t_from(2i64));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sveorv_s64(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorv_s64(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveorv_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveorv_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveorv_u8_impl() -> Result<(), String> {
    unsafe {
        let result = sveorv_u8(create_svbool_t(), create_svuint8_t_from(2u8));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sveorv_u8(create_svbool_t(), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorv_u8(create_svbool_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveorv_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveorv_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveorv_u16_impl() -> Result<(), String> {
    unsafe {
        let result = sveorv_u16(create_svbool_t(), create_svuint16_t_from(2u16));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sveorv_u16(create_svbool_t(), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorv_u16(create_svbool_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveorv_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveorv_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveorv_u32_impl() -> Result<(), String> {
    unsafe {
        let result = sveorv_u32(create_svbool_t(), create_svuint32_t_from(2u32));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sveorv_u32(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorv_u32(create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveorv_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveorv_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_sveorv_u64_impl() -> Result<(), String> {
    unsafe {
        let result = sveorv_u64(create_svbool_t(), create_svuint64_t_from(2u64));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sveorv_u64(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorv_u64(create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_sveorv_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_sveorv_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svexpa_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svexpa_f32(create_svuint32_t_from(1u32)));
        check_float_array_equality(&result, &[0.0f32; 1]).map_err(|e| format!("{e} | call: svexpa_f32(create_svuint32_t_from(1u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svexpa_f32(create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svexpa_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svexpa_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svexpa_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svexpa_f64(create_svuint64_t_from(1u64)));
        check_float_array_equality(&result, &[0.0f64; 1]).map_err(|e| format!("{e} | call: svexpa_f64(create_svuint64_t_from(1u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svexpa_f64(create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svexpa_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svexpa_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svext_f32::<1>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svext_f32::<1>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svext_f32::<1>(create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svext_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svext_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svext_f64::<1>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svext_f64::<1>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svext_f64::<1>(create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svext_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svext_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svext_s8::<1>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svext_s8::<1>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svext_s8::<1>(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svext_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svext_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svext_s16::<1>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svext_s16::<1>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svext_s16::<1>(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svext_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svext_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svext_s32::<1>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svext_s32::<1>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svext_s32::<1>(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svext_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svext_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svext_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svext_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svext_s64::<1>(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svext_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svext_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svext_u8::<1>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svext_u8::<1>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svext_u8::<1>(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svext_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svext_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svext_u16::<1>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svext_u16::<1>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svext_u16::<1>(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svext_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svext_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svext_u32::<1>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svext_u32::<1>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svext_u32::<1>(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svext_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svext_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svext_u64::<1>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svext_u64::<1>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svext_u64::<1>(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svext_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svext_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svextb_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svextb_s16_m(create_svint16_t_from(1i16), create_svbool_t(), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svextb_s16_m(create_svint16_t_from(1i16), create_svbool_t(), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svextb_s16_m(create_random_svint16_t(), create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svextb_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svextb_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svextb_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svextb_s16_x(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svextb_s16_x(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svextb_s16_x(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svextb_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svextb_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svextb_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svextb_s16_z(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svextb_s16_z(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svextb_s16_z(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svextb_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svextb_s16_z_impl() }
}
