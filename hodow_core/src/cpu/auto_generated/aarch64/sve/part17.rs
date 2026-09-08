use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdot_lane_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svdot_lane_u32::<0>(create_svuint32_t_from(1u32), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[25]).map_err(|e| format!("{e} | call: svdot_lane_u32::<0>(create_svuint32_t_from(1u32), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdot_lane_u32::<0>(create_random_svuint32_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdot_lane_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdot_lane_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdot_lane_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svdot_lane_u64::<0>(create_svuint64_t_from(1u64), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[25]).map_err(|e| format!("{e} | call: svdot_lane_u64::<0>(create_svuint64_t_from(1u64), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdot_lane_u64::<0>(create_random_svuint64_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdot_lane_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdot_lane_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdot_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdot_s32(create_svint32_t_from(1i32), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[25]).map_err(|e| format!("{e} | call: svdot_s32(create_svint32_t_from(1i32), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdot_s32(create_random_svint32_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdot_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdot_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdot_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdot_n_s32(create_svint32_t_from(1i32), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[25]).map_err(|e| format!("{e} | call: svdot_n_s32(create_svint32_t_from(1i32), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdot_n_s32(create_random_svint32_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdot_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdot_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdot_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svdot_s64(create_svint64_t_from(1i64), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[25]).map_err(|e| format!("{e} | call: svdot_s64(create_svint64_t_from(1i64), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdot_s64(create_random_svint64_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdot_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdot_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdot_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svdot_n_s64(create_svint64_t_from(1i64), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[25]).map_err(|e| format!("{e} | call: svdot_n_s64(create_svint64_t_from(1i64), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdot_n_s64(create_random_svint64_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdot_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdot_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdot_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svdot_u32(create_svuint32_t_from(1u32), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[25]).map_err(|e| format!("{e} | call: svdot_u32(create_svuint32_t_from(1u32), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdot_u32(create_random_svuint32_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdot_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdot_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdot_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svdot_n_u32(create_svuint32_t_from(1u32), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[25]).map_err(|e| format!("{e} | call: svdot_n_u32(create_svuint32_t_from(1u32), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdot_n_u32(create_random_svuint32_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdot_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdot_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdot_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svdot_u64(create_svuint64_t_from(1u64), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[25]).map_err(|e| format!("{e} | call: svdot_u64(create_svuint64_t_from(1u64), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdot_u64(create_random_svuint64_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdot_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdot_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdot_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svdot_n_u64(create_svuint64_t_from(1u64), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[25]).map_err(|e| format!("{e} | call: svdot_n_u64(create_svuint64_t_from(1u64), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdot_n_u64(create_random_svuint64_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdot_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdot_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_lane_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svdup_lane_f32(create_svfloat32_t_from(1.0f32), 2u32));
        check_float_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: svdup_lane_f32(create_svfloat32_t_from(1.0f32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_lane_f32(create_random_svfloat32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_lane_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_lane_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_lane_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svdup_lane_f64(create_svfloat64_t_from(1.0f64), 2u64));
        check_float_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: svdup_lane_f64(create_svfloat64_t_from(1.0f64), 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_lane_f64(create_random_svfloat64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_lane_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_lane_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_lane_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svdup_lane_s8(create_svint8_t_from(1i8), 2u8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_lane_s8(create_svint8_t_from(1i8), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_lane_s8(create_random_svint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_lane_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_lane_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_lane_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svdup_lane_s16(create_svint16_t_from(1i16), 2u16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_lane_s16(create_svint16_t_from(1i16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_lane_s16(create_random_svint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_lane_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_lane_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdup_lane_s32(create_svint32_t_from(1i32), 2u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_lane_s32(create_svint32_t_from(1i32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_lane_s32(create_random_svint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svdup_lane_s64(create_svint64_t_from(1i64), 2u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_lane_s64(create_svint64_t_from(1i64), 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_lane_s64(create_random_svint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_lane_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svdup_lane_u8(create_svuint8_t_from(1u8), 2u8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_lane_u8(create_svuint8_t_from(1u8), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_lane_u8(create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_lane_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_lane_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_lane_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svdup_lane_u16(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_lane_u16(create_svuint16_t_from(1u16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_lane_u16(create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_lane_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_lane_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_lane_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svdup_lane_u32(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_lane_u32(create_svuint32_t_from(1u32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_lane_u32(create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_lane_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_lane_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_lane_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svdup_lane_u64(create_svuint64_t_from(1u64), 2u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_lane_u64(create_svuint64_t_from(1u64), 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_lane_u64(create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_lane_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_lane_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_b8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svdup_n_b8(true));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_n_b8(true)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_b8(rand::random::<bool>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_b8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_b8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_b16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svdup_n_b16(true));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_n_b16(true)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_b16(rand::random::<bool>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_b16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_b16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_b32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svdup_n_b32(true));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_n_b32(true)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_b32(rand::random::<bool>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_b32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_b32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_b64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svdup_n_b64(true));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_n_b64(true)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_b64(rand::random::<bool>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_b64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_b64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svdup_n_f32(1.0f32));
        check_float_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: svdup_n_f32(1.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_f32(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svdup_n_f64(1.0f64));
        check_float_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: svdup_n_f64(1.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_f64(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svdup_n_s8(1i8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_n_s8(1i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_s8(rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svdup_n_s16(1i16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_n_s16(1i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_s16(rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdup_n_s32(1i32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_n_s32(1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_s32(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svdup_n_s64(1i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_n_s64(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_s64(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svdup_n_u8(1u8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_n_u8(1u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_u8(rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svdup_n_u16(1u16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_n_u16(1u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_u16(rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svdup_n_u32(1u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_n_u32(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_u32(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svdup_n_u64(1u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svdup_n_u64(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svdup_n_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), 3.0f32));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svdup_n_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), 3.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_f32_m(create_random_svfloat32_t(), create_svbool_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svdup_n_f32_x(create_svbool_t(), 2.0f32));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svdup_n_f32_x(create_svbool_t(), 2.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_f32_x(create_svbool_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svdup_n_f32_z(create_svbool_t(), 2.0f32));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svdup_n_f32_z(create_svbool_t(), 2.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_f32_z(create_svbool_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svdup_n_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), 3.0f64));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svdup_n_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), 3.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_f64_m(create_random_svfloat64_t(), create_svbool_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svdup_n_f64_x(create_svbool_t(), 2.0f64));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svdup_n_f64_x(create_svbool_t(), 2.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_f64_x(create_svbool_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svdup_n_f64_z(create_svbool_t(), 2.0f64));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svdup_n_f64_z(create_svbool_t(), 2.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_f64_z(create_svbool_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svdup_n_s8_m(create_svint8_t_from(1i8), create_svbool_t(), 3i8));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svdup_n_s8_m(create_svint8_t_from(1i8), create_svbool_t(), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_s8_m(create_random_svint8_t(), create_svbool_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svdup_n_s8_x(create_svbool_t(), 2i8));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svdup_n_s8_x(create_svbool_t(), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_s8_x(create_svbool_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svdup_n_s8_z(create_svbool_t(), 2i8));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svdup_n_s8_z(create_svbool_t(), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_s8_z(create_svbool_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svdup_n_s16_m(create_svint16_t_from(1i16), create_svbool_t(), 3i16));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svdup_n_s16_m(create_svint16_t_from(1i16), create_svbool_t(), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_s16_m(create_random_svint16_t(), create_svbool_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svdup_n_s16_x(create_svbool_t(), 2i16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svdup_n_s16_x(create_svbool_t(), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_s16_x(create_svbool_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svdup_n_s16_z(create_svbool_t(), 2i16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svdup_n_s16_z(create_svbool_t(), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_s16_z(create_svbool_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdup_n_s32_m(create_svint32_t_from(1i32), create_svbool_t(), 3i32));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svdup_n_s32_m(create_svint32_t_from(1i32), create_svbool_t(), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_s32_m(create_random_svint32_t(), create_svbool_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdup_n_s32_x(create_svbool_t(), 2i32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svdup_n_s32_x(create_svbool_t(), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_s32_x(create_svbool_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdup_n_s32_z(create_svbool_t(), 2i32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svdup_n_s32_z(create_svbool_t(), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_s32_z(create_svbool_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdup_n_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svdup_n_s64_m(create_svint64_t_from(1i64), create_svbool_t(), 3i64));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svdup_n_s64_m(create_svint64_t_from(1i64), create_svbool_t(), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdup_n_s64_m(create_random_svint64_t(), create_svbool_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdup_n_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdup_n_s64_m_impl() }
}
