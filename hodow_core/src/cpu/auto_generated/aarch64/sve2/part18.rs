use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmulh_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqdmulh_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svqdmulh_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmulh_s8(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmulh_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmulh_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmulh_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqdmulh_n_s8(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svqdmulh_n_s8(create_svint8_t_from(1i8), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmulh_n_s8(create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmulh_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmulh_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmulh_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmulh_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svqdmulh_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmulh_s16(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmulh_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmulh_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmulh_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmulh_n_s16(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svqdmulh_n_s16(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmulh_n_s16(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmulh_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmulh_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmulh_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmulh_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svqdmulh_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmulh_s32(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmulh_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmulh_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmulh_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmulh_n_s32(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svqdmulh_n_s32(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmulh_n_s32(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmulh_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmulh_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmulh_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmulh_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svqdmulh_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmulh_s64(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmulh_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmulh_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmulh_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmulh_n_s64(create_svint64_t_from(1i64), 2i64));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svqdmulh_n_s64(create_svint64_t_from(1i64), 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmulh_n_s64(create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmulh_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmulh_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmullb_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmullb_lane_s32::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqdmullb_lane_s32::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmullb_lane_s32::<0>(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmullb_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmullb_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmullb_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmullb_lane_s64::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqdmullb_lane_s64::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmullb_lane_s64::<0>(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmullb_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmullb_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmullb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmullb_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqdmullb_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmullb_s16(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmullb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmullb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmullb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmullb_n_s16(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqdmullb_n_s16(create_svint8_t_from(1i8), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmullb_n_s16(create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmullb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmullb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmullb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmullb_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqdmullb_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmullb_s32(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmullb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmullb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmullb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmullb_n_s32(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqdmullb_n_s32(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmullb_n_s32(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmullb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmullb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmullb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmullb_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqdmullb_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmullb_s64(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmullb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmullb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmullb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmullb_n_s64(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqdmullb_n_s64(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmullb_n_s64(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmullb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmullb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmullt_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmullt_lane_s32::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqdmullt_lane_s32::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmullt_lane_s32::<0>(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmullt_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmullt_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmullt_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmullt_lane_s64::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqdmullt_lane_s64::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmullt_lane_s64::<0>(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmullt_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmullt_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmullt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmullt_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqdmullt_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmullt_s16(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmullt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmullt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmullt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmullt_n_s16(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqdmullt_n_s16(create_svint8_t_from(1i8), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmullt_n_s16(create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmullt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmullt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmullt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmullt_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqdmullt_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmullt_s32(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmullt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmullt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmullt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmullt_n_s32(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqdmullt_n_s32(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmullt_n_s32(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmullt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmullt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmullt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmullt_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqdmullt_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmullt_s64(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmullt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmullt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmullt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmullt_n_s64(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqdmullt_n_s64(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmullt_n_s64(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmullt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmullt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqneg_s8_m(create_svint8_t_from(1i8), create_svbool_t(), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[-3]).map_err(|e| format!("{e} | call: svqneg_s8_m(create_svint8_t_from(1i8), create_svbool_t(), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqneg_s8_m(create_random_svint8_t(), create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqneg_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqneg_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqneg_s8_x(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[-2]).map_err(|e| format!("{e} | call: svqneg_s8_x(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqneg_s8_x(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqneg_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqneg_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqneg_s8_z(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[-2]).map_err(|e| format!("{e} | call: svqneg_s8_z(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqneg_s8_z(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqneg_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqneg_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqneg_s16_m(create_svint16_t_from(1i16), create_svbool_t(), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[-3]).map_err(|e| format!("{e} | call: svqneg_s16_m(create_svint16_t_from(1i16), create_svbool_t(), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqneg_s16_m(create_random_svint16_t(), create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqneg_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqneg_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqneg_s16_x(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[-2]).map_err(|e| format!("{e} | call: svqneg_s16_x(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqneg_s16_x(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqneg_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqneg_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqneg_s16_z(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[-2]).map_err(|e| format!("{e} | call: svqneg_s16_z(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqneg_s16_z(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqneg_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqneg_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqneg_s32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[-3]).map_err(|e| format!("{e} | call: svqneg_s32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqneg_s32_m(create_random_svint32_t(), create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqneg_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqneg_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqneg_s32_x(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[-2]).map_err(|e| format!("{e} | call: svqneg_s32_x(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqneg_s32_x(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqneg_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqneg_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqneg_s32_z(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[-2]).map_err(|e| format!("{e} | call: svqneg_s32_z(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqneg_s32_z(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqneg_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqneg_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqneg_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[-3]).map_err(|e| format!("{e} | call: svqneg_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqneg_s64_m(create_random_svint64_t(), create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqneg_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqneg_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqneg_s64_x(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[-2]).map_err(|e| format!("{e} | call: svqneg_s64_x(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqneg_s64_x(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqneg_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqneg_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqneg_s64_z(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[-2]).map_err(|e| format!("{e} | call: svqneg_s64_z(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqneg_s64_z(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqneg_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqneg_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdcmlah_lane_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrdcmlah_lane_s16::<0, 90>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdcmlah_lane_s16::<0, 90>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdcmlah_lane_s16::<0, 90>(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdcmlah_lane_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdcmlah_lane_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdcmlah_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrdcmlah_lane_s32::<0, 90>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdcmlah_lane_s32::<0, 90>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdcmlah_lane_s32::<0, 90>(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdcmlah_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdcmlah_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdcmlah_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqrdcmlah_s8::<90>(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdcmlah_s8::<90>(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdcmlah_s8::<90>(create_random_svint8_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdcmlah_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdcmlah_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdcmlah_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrdcmlah_s16::<90>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdcmlah_s16::<90>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdcmlah_s16::<90>(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdcmlah_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdcmlah_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdcmlah_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrdcmlah_s32::<90>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdcmlah_s32::<90>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdcmlah_s32::<90>(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdcmlah_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdcmlah_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdcmlah_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrdcmlah_s64::<90>(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdcmlah_s64::<90>(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdcmlah_s64::<90>(create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdcmlah_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdcmlah_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlah_lane_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrdmlah_lane_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlah_lane_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlah_lane_s16::<0>(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlah_lane_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlah_lane_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlah_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrdmlah_lane_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlah_lane_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlah_lane_s32::<0>(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlah_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlah_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlah_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrdmlah_lane_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlah_lane_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlah_lane_s64::<0>(create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlah_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlah_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlah_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqrdmlah_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlah_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlah_s8(create_random_svint8_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlah_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlah_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlah_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqrdmlah_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlah_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlah_n_s8(create_random_svint8_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlah_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlah_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlah_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrdmlah_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlah_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlah_s16(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlah_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlah_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlah_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrdmlah_n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlah_n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlah_n_s16(create_random_svint16_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlah_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlah_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlah_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrdmlah_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlah_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlah_s32(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlah_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlah_s32_impl() }
}
