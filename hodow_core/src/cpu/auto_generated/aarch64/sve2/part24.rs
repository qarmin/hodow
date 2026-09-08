use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqsubr_n_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqsubr_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqsubr_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsubr_n_u16_x(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqsubr_n_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqsubr_n_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqsubr_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqsubr_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqsubr_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsubr_u16_z(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqsubr_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqsubr_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqsubr_n_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqsubr_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqsubr_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsubr_n_u16_z(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqsubr_n_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqsubr_n_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqsubr_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqsubr_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqsubr_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsubr_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqsubr_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqsubr_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqsubr_n_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqsubr_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqsubr_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsubr_n_u32_m(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqsubr_n_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqsubr_n_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqsubr_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqsubr_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqsubr_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsubr_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqsubr_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqsubr_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqsubr_n_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqsubr_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqsubr_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsubr_n_u32_x(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqsubr_n_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqsubr_n_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqsubr_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqsubr_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqsubr_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsubr_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqsubr_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqsubr_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqsubr_n_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqsubr_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqsubr_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsubr_n_u32_z(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqsubr_n_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqsubr_n_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqsubr_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqsubr_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqsubr_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsubr_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqsubr_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqsubr_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqsubr_n_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqsubr_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqsubr_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsubr_n_u64_m(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqsubr_n_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqsubr_n_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqsubr_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqsubr_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqsubr_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsubr_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqsubr_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqsubr_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqsubr_n_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqsubr_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqsubr_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsubr_n_u64_x(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqsubr_n_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqsubr_n_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqsubr_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqsubr_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqsubr_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsubr_u64_z(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqsubr_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqsubr_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqsubr_n_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqsubr_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqsubr_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsubr_n_u64_z(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqsubr_n_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqsubr_n_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtnb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqxtnb_s16(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svqxtnb_s16(create_svint16_t_from(1i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqxtnb_s16(create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqxtnb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqxtnb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtnb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqxtnb_s32(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svqxtnb_s32(create_svint32_t_from(1i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqxtnb_s32(create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqxtnb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqxtnb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtnb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqxtnb_s64(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svqxtnb_s64(create_svint64_t_from(1i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqxtnb_s64(create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqxtnb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqxtnb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtnb_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqxtnb_u16(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svqxtnb_u16(create_svuint16_t_from(1u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqxtnb_u16(create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqxtnb_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqxtnb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtnb_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqxtnb_u32(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svqxtnb_u32(create_svuint32_t_from(1u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqxtnb_u32(create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqxtnb_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqxtnb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtnb_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqxtnb_u64(create_svuint64_t_from(1u64)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svqxtnb_u64(create_svuint64_t_from(1u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqxtnb_u64(create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqxtnb_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqxtnb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtnt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqxtnt_s16(create_svint8_t_from(1i8), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svqxtnt_s16(create_svint8_t_from(1i8), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqxtnt_s16(create_random_svint8_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqxtnt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqxtnt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtnt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqxtnt_s32(create_svint16_t_from(1i16), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svqxtnt_s32(create_svint16_t_from(1i16), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqxtnt_s32(create_random_svint16_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqxtnt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqxtnt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtnt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqxtnt_s64(create_svint32_t_from(1i32), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svqxtnt_s64(create_svint32_t_from(1i32), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqxtnt_s64(create_random_svint32_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqxtnt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqxtnt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtnt_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqxtnt_u16(create_svuint8_t_from(1u8), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svqxtnt_u16(create_svuint8_t_from(1u8), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqxtnt_u16(create_random_svuint8_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqxtnt_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqxtnt_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtnt_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqxtnt_u32(create_svuint16_t_from(1u16), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svqxtnt_u32(create_svuint16_t_from(1u16), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqxtnt_u32(create_random_svuint16_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqxtnt_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqxtnt_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtnt_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqxtnt_u64(create_svuint32_t_from(1u32), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svqxtnt_u64(create_svuint32_t_from(1u32), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqxtnt_u64(create_random_svuint32_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqxtnt_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqxtnt_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtunb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqxtunb_s16(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svqxtunb_s16(create_svint16_t_from(1i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqxtunb_s16(create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqxtunb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqxtunb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtunb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqxtunb_s32(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svqxtunb_s32(create_svint32_t_from(1i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqxtunb_s32(create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqxtunb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqxtunb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtunb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqxtunb_s64(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svqxtunb_s64(create_svint64_t_from(1i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqxtunb_s64(create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqxtunb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqxtunb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtunt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqxtunt_s16(create_svuint8_t_from(1u8), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svqxtunt_s16(create_svuint8_t_from(1u8), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqxtunt_s16(create_random_svuint8_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqxtunt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqxtunt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtunt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqxtunt_s32(create_svuint16_t_from(1u16), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svqxtunt_s32(create_svuint16_t_from(1u16), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqxtunt_s32(create_random_svuint16_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqxtunt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqxtunt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtunt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqxtunt_s64(create_svuint32_t_from(1u32), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svqxtunt_s64(create_svuint32_t_from(1u32), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqxtunt_s64(create_random_svuint32_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqxtunt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqxtunt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svraddhnb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svraddhnb_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svraddhnb_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svraddhnb_s16(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svraddhnb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svraddhnb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svraddhnb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svraddhnb_n_s16(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svraddhnb_n_s16(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svraddhnb_n_s16(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svraddhnb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svraddhnb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svraddhnb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svraddhnb_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svraddhnb_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svraddhnb_s32(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svraddhnb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svraddhnb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svraddhnb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svraddhnb_n_s32(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svraddhnb_n_s32(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svraddhnb_n_s32(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svraddhnb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svraddhnb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svraddhnb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svraddhnb_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svraddhnb_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svraddhnb_s64(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svraddhnb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svraddhnb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svraddhnb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svraddhnb_n_s64(create_svint64_t_from(1i64), 2i64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svraddhnb_n_s64(create_svint64_t_from(1i64), 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svraddhnb_n_s64(create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svraddhnb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svraddhnb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svraddhnb_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svraddhnb_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svraddhnb_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svraddhnb_u16(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svraddhnb_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svraddhnb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svraddhnb_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svraddhnb_n_u16(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svraddhnb_n_u16(create_svuint16_t_from(1u16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svraddhnb_n_u16(create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svraddhnb_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svraddhnb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svraddhnb_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svraddhnb_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svraddhnb_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svraddhnb_u32(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svraddhnb_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svraddhnb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svraddhnb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svraddhnb_n_u32(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svraddhnb_n_u32(create_svuint32_t_from(1u32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svraddhnb_n_u32(create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svraddhnb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svraddhnb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svraddhnb_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svraddhnb_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svraddhnb_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svraddhnb_u64(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svraddhnb_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svraddhnb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svraddhnb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svraddhnb_n_u64(create_svuint64_t_from(1u64), 2u64));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svraddhnb_n_u64(create_svuint64_t_from(1u64), 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svraddhnb_n_u64(create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svraddhnb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svraddhnb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svraddhnt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svraddhnt_s16(create_svint8_t_from(1i8), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svraddhnt_s16(create_svint8_t_from(1i8), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svraddhnt_s16(create_random_svint8_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svraddhnt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svraddhnt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svraddhnt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svraddhnt_n_s16(create_svint8_t_from(1i8), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svraddhnt_n_s16(create_svint8_t_from(1i8), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svraddhnt_n_s16(create_random_svint8_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svraddhnt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svraddhnt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svraddhnt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svraddhnt_s32(create_svint16_t_from(1i16), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svraddhnt_s32(create_svint16_t_from(1i16), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svraddhnt_s32(create_random_svint16_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svraddhnt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svraddhnt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svraddhnt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svraddhnt_n_s32(create_svint16_t_from(1i16), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svraddhnt_n_s32(create_svint16_t_from(1i16), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svraddhnt_n_s32(create_random_svint16_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svraddhnt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svraddhnt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svraddhnt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svraddhnt_s64(create_svint32_t_from(1i32), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svraddhnt_s64(create_svint32_t_from(1i32), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svraddhnt_s64(create_random_svint32_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svraddhnt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svraddhnt_s64_impl() }
}
