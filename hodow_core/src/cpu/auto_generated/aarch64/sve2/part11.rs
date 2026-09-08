use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svhsubr_n_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svhsubr_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svhsubr_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svhsubr_n_u32_m(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svhsubr_n_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svhsubr_n_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svhsubr_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svhsubr_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svhsubr_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svhsubr_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svhsubr_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svhsubr_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svhsubr_n_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svhsubr_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svhsubr_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svhsubr_n_u32_x(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svhsubr_n_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svhsubr_n_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svhsubr_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svhsubr_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svhsubr_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svhsubr_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svhsubr_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svhsubr_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svhsubr_n_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svhsubr_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svhsubr_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svhsubr_n_u32_z(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svhsubr_n_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svhsubr_n_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svhsubr_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svhsubr_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svhsubr_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svhsubr_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svhsubr_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svhsubr_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svhsubr_n_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svhsubr_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svhsubr_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svhsubr_n_u64_m(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svhsubr_n_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svhsubr_n_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svhsubr_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svhsubr_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svhsubr_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svhsubr_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svhsubr_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svhsubr_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svhsubr_n_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svhsubr_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svhsubr_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svhsubr_n_u64_x(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svhsubr_n_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svhsubr_n_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svhsubr_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svhsubr_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svhsubr_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svhsubr_u64_z(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svhsubr_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svhsubr_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svhsubr_n_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svhsubr_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svhsubr_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svhsubr_n_u64_z(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svhsubr_n_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svhsubr_n_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svlogb_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svlogb_f32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svlogb_f32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlogb_f32_m(create_random_svint32_t(), create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svlogb_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svlogb_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svlogb_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svlogb_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svlogb_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlogb_f32_x(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svlogb_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svlogb_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svlogb_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svlogb_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svlogb_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlogb_f32_z(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svlogb_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svlogb_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svlogb_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svlogb_f64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svlogb_f64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlogb_f64_m(create_random_svint64_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svlogb_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svlogb_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svlogb_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svlogb_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svlogb_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlogb_f64_x(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svlogb_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svlogb_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svlogb_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svlogb_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svlogb_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlogb_f64_z(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svlogb_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svlogb_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmatch_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svmatch_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svmatch_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmatch_s8(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmatch_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmatch_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmatch_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svmatch_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svmatch_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmatch_s16(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmatch_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmatch_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmatch_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svmatch_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svmatch_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmatch_u8(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmatch_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmatch_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmatch_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svmatch_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svmatch_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmatch_u16(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmatch_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmatch_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxnmp_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svmaxnmp_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svmaxnmp_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxnmp_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxnmp_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxnmp_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxnmp_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svmaxnmp_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svmaxnmp_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxnmp_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxnmp_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxnmp_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxnmp_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svmaxnmp_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svmaxnmp_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxnmp_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxnmp_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxnmp_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxnmp_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svmaxnmp_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svmaxnmp_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxnmp_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxnmp_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxnmp_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svmaxp_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svmaxp_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svmaxp_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svmaxp_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svmaxp_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svmaxp_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svmaxp_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svmaxp_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svmaxp_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svmaxp_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_s8_m(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svmaxp_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svmaxp_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_s8_x(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmaxp_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svmaxp_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_s16_m(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmaxp_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svmaxp_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_s16_x(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmaxp_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svmaxp_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_s32_m(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmaxp_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svmaxp_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_s32_x(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmaxp_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svmaxp_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_s64_m(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmaxp_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svmaxp_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_s64_x(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svmaxp_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svmaxp_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_u8_m(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svmaxp_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svmaxp_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_u8_x(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmaxp_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svmaxp_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_u16_m(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmaxp_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svmaxp_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_u16_x(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmaxp_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svmaxp_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmaxp_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svmaxp_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmaxp_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svmaxp_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmaxp_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmaxp_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svmaxp_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmaxp_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmaxp_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmaxp_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminnmp_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svminnmp_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svminnmp_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminnmp_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminnmp_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminnmp_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminnmp_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svminnmp_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svminnmp_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminnmp_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminnmp_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminnmp_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminnmp_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svminnmp_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svminnmp_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminnmp_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminnmp_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminnmp_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminnmp_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svminnmp_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svminnmp_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminnmp_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminnmp_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminnmp_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svminp_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svminp_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_f32_m_impl() }
}
