use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svlsr_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_n_u8_x(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_n_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_n_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svlsr_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_u8_z(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svlsr_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_n_u8_z(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_n_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_n_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svlsr_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_u16_m(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svlsr_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_n_u16_m(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_n_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_n_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svlsr_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_u16_x(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svlsr_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_n_u16_x(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_n_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_n_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svlsr_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_u16_z(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svlsr_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_n_u16_z(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_n_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_n_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svlsr_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svlsr_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_n_u32_m(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_n_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_n_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svlsr_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svlsr_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_n_u32_x(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_n_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_n_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svlsr_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svlsr_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_n_u32_z(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_n_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_n_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svlsr_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svlsr_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svlsr_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svlsr_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_n_u64_m(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_n_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_n_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svlsr_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svlsr_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svlsr_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svlsr_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_n_u64_x(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_n_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_n_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svlsr_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svlsr_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_u64_z(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svlsr_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svlsr_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_n_u64_z(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_n_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_n_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_wide_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svlsr_wide_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_wide_u8_m(create_svbool_t(), create_random_svuint8_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_wide_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_wide_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_n_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_wide_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3u64));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svlsr_wide_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_wide_n_u8_m(create_svbool_t(), create_random_svuint8_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_wide_n_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_wide_n_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_wide_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svlsr_wide_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_wide_u8_x(create_svbool_t(), create_random_svuint8_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_wide_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_wide_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_n_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_wide_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3u64));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svlsr_wide_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_wide_n_u8_x(create_svbool_t(), create_random_svuint8_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_wide_n_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_wide_n_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_wide_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svlsr_wide_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_wide_u8_z(create_svbool_t(), create_random_svuint8_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_wide_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_wide_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_n_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_wide_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3u64));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svlsr_wide_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_wide_n_u8_z(create_svbool_t(), create_random_svuint8_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_wide_n_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_wide_n_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_wide_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svlsr_wide_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_wide_u16_m(create_svbool_t(), create_random_svuint16_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_wide_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_wide_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_n_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_wide_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3u64));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svlsr_wide_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_wide_n_u16_m(create_svbool_t(), create_random_svuint16_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_wide_n_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_wide_n_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_wide_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svlsr_wide_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_wide_u16_x(create_svbool_t(), create_random_svuint16_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_wide_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_wide_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_n_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_wide_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u64));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svlsr_wide_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_wide_n_u16_x(create_svbool_t(), create_random_svuint16_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_wide_n_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_wide_n_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_wide_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svlsr_wide_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_wide_u16_z(create_svbool_t(), create_random_svuint16_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_wide_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_wide_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_n_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_wide_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u64));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svlsr_wide_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_wide_n_u16_z(create_svbool_t(), create_random_svuint16_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_wide_n_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_wide_n_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_wide_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svlsr_wide_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_wide_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_wide_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_wide_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_n_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_wide_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u64));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svlsr_wide_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_wide_n_u32_m(create_svbool_t(), create_random_svuint32_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_wide_n_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_wide_n_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_wide_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svlsr_wide_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_wide_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_wide_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_wide_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_n_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_wide_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u64));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svlsr_wide_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_wide_n_u32_x(create_svbool_t(), create_random_svuint32_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_wide_n_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_wide_n_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_wide_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svlsr_wide_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_wide_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_wide_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_wide_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_n_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_wide_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u64));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svlsr_wide_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_wide_n_u32_z(create_svbool_t(), create_random_svuint32_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_wide_n_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_wide_n_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmad_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svmad_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svmad_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmad_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmad_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmad_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmad_n_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svmad_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svmad_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmad_n_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmad_n_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmad_n_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmad_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svmad_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svmad_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmad_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmad_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmad_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmad_n_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svmad_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svmad_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmad_n_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmad_n_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmad_n_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmad_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svmad_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svmad_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmad_f32_z(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmad_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmad_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmad_n_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svmad_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svmad_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmad_n_f32_z(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmad_n_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmad_n_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmad_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svmad_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svmad_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmad_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmad_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmad_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmad_n_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svmad_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svmad_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmad_n_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmad_n_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmad_n_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmad_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svmad_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svmad_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmad_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmad_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmad_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmad_n_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svmad_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svmad_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmad_n_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmad_n_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmad_n_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmad_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svmad_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svmad_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmad_f64_z(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmad_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmad_f64_z_impl() }
}
