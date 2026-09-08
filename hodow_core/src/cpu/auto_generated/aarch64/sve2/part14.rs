use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmovlb_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmovlb_u64(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svmovlb_u64(create_svuint32_t_from(1u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmovlb_u64(create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmovlb_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmovlb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmovlt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmovlt_s16(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svmovlt_s16(create_svint8_t_from(1i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmovlt_s16(create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmovlt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmovlt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmovlt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmovlt_s32(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svmovlt_s32(create_svint16_t_from(1i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmovlt_s32(create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmovlt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmovlt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmovlt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmovlt_s64(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svmovlt_s64(create_svint32_t_from(1i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmovlt_s64(create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmovlt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmovlt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmovlt_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmovlt_u16(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svmovlt_u16(create_svuint8_t_from(1u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmovlt_u16(create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmovlt_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmovlt_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmovlt_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmovlt_u32(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svmovlt_u32(create_svuint16_t_from(1u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmovlt_u32(create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmovlt_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmovlt_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmovlt_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmovlt_u64(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svmovlt_u64(create_svuint32_t_from(1u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmovlt_u64(create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmovlt_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmovlt_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmul_lane_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svmul_lane_f32::<0>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svmul_lane_f32::<0>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmul_lane_f32::<0>(create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmul_lane_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmul_lane_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmul_lane_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svmul_lane_f64::<0>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svmul_lane_f64::<0>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmul_lane_f64::<0>(create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmul_lane_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmul_lane_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmul_lane_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmul_lane_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmul_lane_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmul_lane_s16::<0>(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmul_lane_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmul_lane_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmul_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmul_lane_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmul_lane_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmul_lane_s32::<0>(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmul_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmul_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmul_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmul_lane_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmul_lane_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmul_lane_s64::<0>(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmul_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmul_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmul_lane_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmul_lane_u16::<0>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmul_lane_u16::<0>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmul_lane_u16::<0>(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmul_lane_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmul_lane_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmul_lane_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmul_lane_u32::<0>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmul_lane_u32::<0>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmul_lane_u32::<0>(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmul_lane_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmul_lane_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmul_lane_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmul_lane_u64::<0>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmul_lane_u64::<0>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmul_lane_u64::<0>(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmul_lane_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmul_lane_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullb_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmullb_lane_s32::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullb_lane_s32::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullb_lane_s32::<0>(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullb_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullb_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullb_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmullb_lane_s64::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullb_lane_s64::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullb_lane_s64::<0>(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullb_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullb_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullb_lane_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmullb_lane_u32::<0>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullb_lane_u32::<0>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullb_lane_u32::<0>(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullb_lane_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullb_lane_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullb_lane_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmullb_lane_u64::<0>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullb_lane_u64::<0>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullb_lane_u64::<0>(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullb_lane_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullb_lane_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmullb_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullb_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullb_s16(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmullb_n_s16(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullb_n_s16(create_svint8_t_from(1i8), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullb_n_s16(create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmullb_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullb_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullb_s32(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmullb_n_s32(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullb_n_s32(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullb_n_s32(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmullb_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullb_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullb_s64(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmullb_n_s64(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullb_n_s64(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullb_n_s64(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullb_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmullb_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullb_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullb_u16(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullb_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullb_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmullb_n_u16(create_svuint8_t_from(1u8), 2u8));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullb_n_u16(create_svuint8_t_from(1u8), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullb_n_u16(create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullb_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullb_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmullb_u32(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullb_u32(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullb_u32(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullb_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmullb_n_u32(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullb_n_u32(create_svuint16_t_from(1u16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullb_n_u32(create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullb_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmullb_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullb_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullb_u64(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullb_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmullb_n_u64(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullb_n_u64(create_svuint32_t_from(1u32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullb_n_u64(create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullt_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmullt_lane_s32::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullt_lane_s32::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullt_lane_s32::<0>(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullt_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullt_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullt_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmullt_lane_s64::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullt_lane_s64::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullt_lane_s64::<0>(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullt_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullt_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullt_lane_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmullt_lane_u32::<0>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullt_lane_u32::<0>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullt_lane_u32::<0>(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullt_lane_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullt_lane_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullt_lane_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmullt_lane_u64::<0>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullt_lane_u64::<0>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullt_lane_u64::<0>(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullt_lane_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullt_lane_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmullt_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullt_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullt_s16(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmullt_n_s16(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullt_n_s16(create_svint8_t_from(1i8), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullt_n_s16(create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmullt_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullt_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullt_s32(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmullt_n_s32(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullt_n_s32(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullt_n_s32(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmullt_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullt_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullt_s64(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmullt_n_s64(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullt_n_s64(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullt_n_s64(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullt_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmullt_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullt_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullt_u16(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullt_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullt_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullt_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmullt_n_u16(create_svuint8_t_from(1u8), 2u8));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullt_n_u16(create_svuint8_t_from(1u8), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullt_n_u16(create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullt_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullt_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullt_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmullt_u32(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullt_u32(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullt_u32(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullt_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullt_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmullt_n_u32(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullt_n_u32(create_svuint16_t_from(1u16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullt_n_u32(create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullt_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmullt_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullt_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullt_u64(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullt_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullt_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmullt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmullt_n_u64(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svmullt_n_u64(create_svuint32_t_from(1u32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmullt_n_u64(create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmullt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmullt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svnbsl_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svnbsl_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[-2]).map_err(|e| format!("{e} | call: svnbsl_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnbsl_s8(create_random_svint8_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svnbsl_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svnbsl_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svnbsl_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svnbsl_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[-2]).map_err(|e| format!("{e} | call: svnbsl_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnbsl_n_s8(create_random_svint8_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svnbsl_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svnbsl_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svnbsl_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svnbsl_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[-2]).map_err(|e| format!("{e} | call: svnbsl_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnbsl_s16(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svnbsl_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svnbsl_s16_impl() }
}
