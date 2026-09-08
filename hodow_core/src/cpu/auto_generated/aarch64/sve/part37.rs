use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svorr_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_n_u8_z(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_n_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_n_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svorr_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_u16_m(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svorr_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_n_u16_m(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_n_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_n_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svorr_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_u16_x(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svorr_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_n_u16_x(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_n_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_n_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svorr_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_u16_z(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svorr_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_n_u16_z(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_n_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_n_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svorr_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svorr_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_n_u32_m(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_n_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_n_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svorr_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svorr_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_n_u32_x(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_n_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_n_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svorr_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svorr_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_n_u32_z(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_n_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_n_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svorr_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svorr_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_n_u64_m(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_n_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_n_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svorr_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svorr_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_n_u64_x(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_n_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_n_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svorr_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_u64_z(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svorr_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svorr_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorr_n_u64_z(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorr_n_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorr_n_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorv_s8_impl() -> Result<(), String> {
    unsafe {
        let result = svorv_s8(create_svbool_t(), create_svint8_t_from(2i8));
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: svorv_s8(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorv_s8(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorv_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorv_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorv_s16_impl() -> Result<(), String> {
    unsafe {
        let result = svorv_s16(create_svbool_t(), create_svint16_t_from(2i16));
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: svorv_s16(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorv_s16(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorv_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorv_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorv_s32_impl() -> Result<(), String> {
    unsafe {
        let result = svorv_s32(create_svbool_t(), create_svint32_t_from(2i32));
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: svorv_s32(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorv_s32(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorv_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorv_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorv_s64_impl() -> Result<(), String> {
    unsafe {
        let result = svorv_s64(create_svbool_t(), create_svint64_t_from(2i64));
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: svorv_s64(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorv_s64(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorv_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorv_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorv_u8_impl() -> Result<(), String> {
    unsafe {
        let result = svorv_u8(create_svbool_t(), create_svuint8_t_from(2u8));
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: svorv_u8(create_svbool_t(), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorv_u8(create_svbool_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorv_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorv_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorv_u16_impl() -> Result<(), String> {
    unsafe {
        let result = svorv_u16(create_svbool_t(), create_svuint16_t_from(2u16));
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: svorv_u16(create_svbool_t(), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorv_u16(create_svbool_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorv_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorv_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorv_u32_impl() -> Result<(), String> {
    unsafe {
        let result = svorv_u32(create_svbool_t(), create_svuint32_t_from(2u32));
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: svorv_u32(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorv_u32(create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorv_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorv_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorv_u64_impl() -> Result<(), String> {
    unsafe {
        let result = svorv_u64(create_svbool_t(), create_svuint64_t_from(2u64));
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: svorv_u64(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svorv_u64(create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svorv_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svorv_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svpfalse_b_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svpfalse_b());
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svpfalse_b()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svpfalse_b();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svpfalse_b() -> Result<(), String> {
    unsafe { test_aarch64_sve_svpfalse_b_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svpfirst_b_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svpfirst_b(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svpfirst_b(create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svpfirst_b(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svpfirst_b() -> Result<(), String> {
    unsafe { test_aarch64_sve_svpfirst_b_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svpnext_b8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svpnext_b8(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svpnext_b8(create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svpnext_b8(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svpnext_b8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svpnext_b8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svpnext_b16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svpnext_b16(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svpnext_b16(create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svpnext_b16(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svpnext_b16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svpnext_b16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svpnext_b32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svpnext_b32(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svpnext_b32(create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svpnext_b32(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svpnext_b32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svpnext_b32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svpnext_b64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svpnext_b64(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svpnext_b64(create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svpnext_b64(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svpnext_b64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svpnext_b64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptest_any_impl() -> Result<(), String> {
    unsafe {
        let _result = svptest_any(create_svbool_t(), create_svbool_t());

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svptest_any(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svptest_any() -> Result<(), String> {
    unsafe { test_aarch64_sve_svptest_any_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptest_first_impl() -> Result<(), String> {
    unsafe {
        let _result = svptest_first(create_svbool_t(), create_svbool_t());

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svptest_first(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svptest_first() -> Result<(), String> {
    unsafe { test_aarch64_sve_svptest_first_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptest_last_impl() -> Result<(), String> {
    unsafe {
        let _result = svptest_last(create_svbool_t(), create_svbool_t());

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svptest_last(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svptest_last() -> Result<(), String> {
    unsafe { test_aarch64_sve_svptest_last_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptrue_b8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svptrue_b8());
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svptrue_b8()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svptrue_b8();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svptrue_b8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svptrue_b8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptrue_b16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svptrue_b16());
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svptrue_b16()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svptrue_b16();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svptrue_b16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svptrue_b16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptrue_b32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svptrue_b32());
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svptrue_b32()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svptrue_b32();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svptrue_b32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svptrue_b32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptrue_b64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svptrue_b64());
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svptrue_b64()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svptrue_b64();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svptrue_b64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svptrue_b64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptrue_pat_b8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svptrue_pat_b8::<{ svpattern::SV_ALL }>());
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svptrue_pat_b8::<{{ svpattern::SV_ALL }}>()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svptrue_pat_b8::<{ svpattern::SV_ALL }>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svptrue_pat_b8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svptrue_pat_b8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptrue_pat_b16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svptrue_pat_b16::<{ svpattern::SV_ALL }>());
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svptrue_pat_b16::<{{ svpattern::SV_ALL }}>()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svptrue_pat_b16::<{ svpattern::SV_ALL }>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svptrue_pat_b16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svptrue_pat_b16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptrue_pat_b32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svptrue_pat_b32::<{ svpattern::SV_ALL }>());
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svptrue_pat_b32::<{{ svpattern::SV_ALL }}>()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svptrue_pat_b32::<{ svpattern::SV_ALL }>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svptrue_pat_b32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svptrue_pat_b32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptrue_pat_b64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svptrue_pat_b64::<{ svpattern::SV_ALL }>());
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svptrue_pat_b64::<{{ svpattern::SV_ALL }}>()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svptrue_pat_b64::<{ svpattern::SV_ALL }>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svptrue_pat_b64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svptrue_pat_b64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqadd_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqadd_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqadd_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqadd_s8(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqadd_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqadd_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqadd_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqadd_n_s8(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqadd_n_s8(create_svint8_t_from(1i8), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqadd_n_s8(create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqadd_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqadd_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqadd_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqadd_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqadd_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqadd_s16(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqadd_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqadd_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqadd_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqadd_n_s16(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqadd_n_s16(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqadd_n_s16(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqadd_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqadd_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqadd_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqadd_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqadd_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqadd_s32(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqadd_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqadd_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqadd_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqadd_n_s32(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqadd_n_s32(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqadd_n_s32(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqadd_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqadd_n_s32_impl() }
}
