use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_n_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svand_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_n_u8_x(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_n_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_n_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svand_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_u8_z(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_n_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svand_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_n_u8_z(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_n_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_n_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svand_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_u16_m(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_n_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svand_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_n_u16_m(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_n_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_n_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svand_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_u16_x(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_n_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svand_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_n_u16_x(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_n_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_n_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svand_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_u16_z(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_n_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svand_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_n_u16_z(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_n_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_n_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svand_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_n_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svand_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_n_u32_m(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_n_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_n_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svand_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_n_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svand_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_n_u32_x(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_n_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_n_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svand_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_n_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svand_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_n_u32_z(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_n_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_n_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svand_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_n_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svand_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_n_u64_m(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_n_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_n_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svand_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_n_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svand_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_n_u64_x(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_n_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_n_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svand_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_u64_z(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svand_n_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svand_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svand_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svand_n_u64_z(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svand_n_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svand_n_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svandv_s8_impl() -> Result<(), String> {
    unsafe {
        let result = svandv_s8(create_svbool_t(), create_svint8_t_from(2i8));
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: svandv_s8(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svandv_s8(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svandv_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svandv_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svandv_s16_impl() -> Result<(), String> {
    unsafe {
        let result = svandv_s16(create_svbool_t(), create_svint16_t_from(2i16));
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: svandv_s16(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svandv_s16(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svandv_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svandv_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svandv_s32_impl() -> Result<(), String> {
    unsafe {
        let result = svandv_s32(create_svbool_t(), create_svint32_t_from(2i32));
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: svandv_s32(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svandv_s32(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svandv_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svandv_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svandv_s64_impl() -> Result<(), String> {
    unsafe {
        let result = svandv_s64(create_svbool_t(), create_svint64_t_from(2i64));
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: svandv_s64(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svandv_s64(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svandv_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svandv_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svandv_u8_impl() -> Result<(), String> {
    unsafe {
        let result = svandv_u8(create_svbool_t(), create_svuint8_t_from(2u8));
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: svandv_u8(create_svbool_t(), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svandv_u8(create_svbool_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svandv_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svandv_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svandv_u16_impl() -> Result<(), String> {
    unsafe {
        let result = svandv_u16(create_svbool_t(), create_svuint16_t_from(2u16));
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: svandv_u16(create_svbool_t(), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svandv_u16(create_svbool_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svandv_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svandv_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svandv_u32_impl() -> Result<(), String> {
    unsafe {
        let result = svandv_u32(create_svbool_t(), create_svuint32_t_from(2u32));
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: svandv_u32(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svandv_u32(create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svandv_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svandv_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svandv_u64_impl() -> Result<(), String> {
    unsafe {
        let result = svandv_u64(create_svbool_t(), create_svuint64_t_from(2u64));
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: svandv_u64(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svandv_u64(create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svandv_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svandv_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasr_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svasr_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_s8_m(create_svbool_t(), create_random_svint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_n_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasr_n_s8_m(create_svbool_t(), create_svint8_t_from(2i8), 3u8));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svasr_n_s8_m(create_svbool_t(), create_svint8_t_from(2i8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_n_s8_m(create_svbool_t(), create_random_svint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_n_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_n_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasr_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svasr_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_s8_x(create_svbool_t(), create_random_svint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_n_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasr_n_s8_x(create_svbool_t(), create_svint8_t_from(2i8), 3u8));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svasr_n_s8_x(create_svbool_t(), create_svint8_t_from(2i8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_n_s8_x(create_svbool_t(), create_random_svint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_n_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_n_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasr_s8_z(create_svbool_t(), create_svint8_t_from(2i8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svasr_s8_z(create_svbool_t(), create_svint8_t_from(2i8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_s8_z(create_svbool_t(), create_random_svint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_n_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasr_n_s8_z(create_svbool_t(), create_svint8_t_from(2i8), 3u8));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svasr_n_s8_z(create_svbool_t(), create_svint8_t_from(2i8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_n_s8_z(create_svbool_t(), create_random_svint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_n_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_n_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasr_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svasr_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_s16_m(create_svbool_t(), create_random_svint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_n_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasr_n_s16_m(create_svbool_t(), create_svint16_t_from(2i16), 3u16));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svasr_n_s16_m(create_svbool_t(), create_svint16_t_from(2i16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_n_s16_m(create_svbool_t(), create_random_svint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_n_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_n_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasr_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svasr_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_s16_x(create_svbool_t(), create_random_svint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_n_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasr_n_s16_x(create_svbool_t(), create_svint16_t_from(2i16), 3u16));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svasr_n_s16_x(create_svbool_t(), create_svint16_t_from(2i16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_n_s16_x(create_svbool_t(), create_random_svint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_n_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_n_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasr_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svasr_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_s16_z(create_svbool_t(), create_random_svint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_n_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasr_n_s16_z(create_svbool_t(), create_svint16_t_from(2i16), 3u16));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svasr_n_s16_z(create_svbool_t(), create_svint16_t_from(2i16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_n_s16_z(create_svbool_t(), create_random_svint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_n_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_n_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasr_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svasr_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_s32_m(create_svbool_t(), create_random_svint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_n_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasr_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3u32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svasr_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_n_s32_m(create_svbool_t(), create_random_svint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_n_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_n_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasr_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svasr_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_s32_x(create_svbool_t(), create_random_svint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_n_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasr_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3u32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svasr_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_n_s32_x(create_svbool_t(), create_random_svint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_n_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_n_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasr_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svasr_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_s32_z(create_svbool_t(), create_random_svint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_n_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasr_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), 3u32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svasr_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_n_s32_z(create_svbool_t(), create_random_svint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_n_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_n_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasr_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svasr_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_s64_m(create_svbool_t(), create_random_svint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_n_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasr_n_s64_m(create_svbool_t(), create_svint64_t_from(2i64), 3u64));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svasr_n_s64_m(create_svbool_t(), create_svint64_t_from(2i64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_n_s64_m(create_svbool_t(), create_random_svint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_n_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_n_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasr_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svasr_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_s64_x(create_svbool_t(), create_random_svint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_s64_x_impl() }
}
