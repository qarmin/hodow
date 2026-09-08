use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmlalt_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalt_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalt_n_s64(create_random_svint64_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalt_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmlalt_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalt_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalt_u16(create_random_svuint16_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalt_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalt_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalt_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmlalt_n_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalt_n_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalt_n_u16(create_random_svuint16_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalt_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalt_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalt_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmlalt_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalt_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalt_u32(create_random_svuint32_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalt_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalt_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmlalt_n_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalt_n_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalt_n_u32(create_random_svuint32_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalt_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmlalt_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalt_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalt_u64(create_random_svuint64_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalt_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalt_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmlalt_n_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalt_n_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalt_n_u64(create_random_svuint64_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmls_lane_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmls_lane_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmls_lane_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_lane_s16::<0>(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmls_lane_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmls_lane_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmls_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmls_lane_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmls_lane_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_lane_s32::<0>(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmls_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmls_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmls_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmls_lane_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmls_lane_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_lane_s64::<0>(create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmls_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmls_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmls_lane_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmls_lane_u16::<0>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[65531]).map_err(|e| format!("{e} | call: svmls_lane_u16::<0>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_lane_u16::<0>(create_random_svuint16_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmls_lane_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmls_lane_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmls_lane_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmls_lane_u32::<0>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[4294967291]).map_err(|e| format!("{e} | call: svmls_lane_u32::<0>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_lane_u32::<0>(create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmls_lane_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmls_lane_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmls_lane_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmls_lane_u64::<0>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[18446744073709551611]).map_err(|e| format!("{e} | call: svmls_lane_u64::<0>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_lane_u64::<0>(create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmls_lane_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmls_lane_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslb_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmlslb_lane_s32::<0>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmlslb_lane_s32::<0>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslb_lane_s32::<0>(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslb_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslb_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslb_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmlslb_lane_s64::<0>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmlslb_lane_s64::<0>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslb_lane_s64::<0>(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslb_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslb_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslb_lane_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmlslb_lane_u32::<0>(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[4294967291]).map_err(|e| format!("{e} | call: svmlslb_lane_u32::<0>(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslb_lane_u32::<0>(create_random_svuint32_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslb_lane_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslb_lane_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslb_lane_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmlslb_lane_u64::<0>(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[18446744073709551611]).map_err(|e| format!("{e} | call: svmlslb_lane_u64::<0>(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslb_lane_u64::<0>(create_random_svuint64_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslb_lane_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslb_lane_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmlslb_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmlslb_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslb_s16(create_random_svint16_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmlslb_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmlslb_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslb_n_s16(create_random_svint16_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmlslb_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmlslb_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslb_s32(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmlslb_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmlslb_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslb_n_s32(create_random_svint32_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmlslb_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmlslb_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslb_s64(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmlslb_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmlslb_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslb_n_s64(create_random_svint64_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslb_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmlslb_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[65531]).map_err(|e| format!("{e} | call: svmlslb_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslb_u16(create_random_svuint16_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslb_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslb_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmlslb_n_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[65531]).map_err(|e| format!("{e} | call: svmlslb_n_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslb_n_u16(create_random_svuint16_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslb_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslb_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmlslb_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[4294967291]).map_err(|e| format!("{e} | call: svmlslb_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslb_u32(create_random_svuint32_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslb_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmlslb_n_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[4294967291]).map_err(|e| format!("{e} | call: svmlslb_n_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslb_n_u32(create_random_svuint32_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslb_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmlslb_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[18446744073709551611]).map_err(|e| format!("{e} | call: svmlslb_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslb_u64(create_random_svuint64_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslb_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmlslb_n_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[18446744073709551611]).map_err(|e| format!("{e} | call: svmlslb_n_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslb_n_u64(create_random_svuint64_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslt_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmlslt_lane_s32::<0>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmlslt_lane_s32::<0>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslt_lane_s32::<0>(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslt_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslt_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslt_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmlslt_lane_s64::<0>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmlslt_lane_s64::<0>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslt_lane_s64::<0>(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslt_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslt_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslt_lane_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmlslt_lane_u32::<0>(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[4294967291]).map_err(|e| format!("{e} | call: svmlslt_lane_u32::<0>(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslt_lane_u32::<0>(create_random_svuint32_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslt_lane_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslt_lane_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslt_lane_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmlslt_lane_u64::<0>(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[18446744073709551611]).map_err(|e| format!("{e} | call: svmlslt_lane_u64::<0>(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslt_lane_u64::<0>(create_random_svuint64_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslt_lane_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslt_lane_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmlslt_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmlslt_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslt_s16(create_random_svint16_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmlslt_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmlslt_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslt_n_s16(create_random_svint16_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmlslt_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmlslt_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslt_s32(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmlslt_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmlslt_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslt_n_s32(create_random_svint32_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmlslt_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmlslt_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslt_s64(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmlslt_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[-5]).map_err(|e| format!("{e} | call: svmlslt_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslt_n_s64(create_random_svint64_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslt_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmlslt_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[65531]).map_err(|e| format!("{e} | call: svmlslt_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslt_u16(create_random_svuint16_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslt_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslt_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslt_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmlslt_n_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[65531]).map_err(|e| format!("{e} | call: svmlslt_n_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslt_n_u16(create_random_svuint16_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslt_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslt_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslt_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmlslt_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[4294967291]).map_err(|e| format!("{e} | call: svmlslt_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslt_u32(create_random_svuint32_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslt_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslt_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmlslt_n_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[4294967291]).map_err(|e| format!("{e} | call: svmlslt_n_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslt_n_u32(create_random_svuint32_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslt_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmlslt_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[18446744073709551611]).map_err(|e| format!("{e} | call: svmlslt_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslt_u64(create_random_svuint64_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslt_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslt_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlslt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmlslt_n_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[18446744073709551611]).map_err(|e| format!("{e} | call: svmlslt_n_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlslt_n_u64(create_random_svuint64_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlslt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlslt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmovlb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmovlb_s16(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svmovlb_s16(create_svint8_t_from(1i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmovlb_s16(create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmovlb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmovlb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmovlb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmovlb_s32(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svmovlb_s32(create_svint16_t_from(1i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmovlb_s32(create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmovlb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmovlb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmovlb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmovlb_s64(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svmovlb_s64(create_svint32_t_from(1i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmovlb_s64(create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmovlb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmovlb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmovlb_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmovlb_u16(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svmovlb_u16(create_svuint8_t_from(1u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmovlb_u16(create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmovlb_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmovlb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmovlb_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmovlb_u32(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svmovlb_u32(create_svuint16_t_from(1u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmovlb_u32(create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmovlb_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmovlb_u32_impl() }
}
