use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlah_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrdmlah_n_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlah_n_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlah_n_s32(create_random_svint32_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlah_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlah_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlah_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrdmlah_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlah_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlah_s64(create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlah_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlah_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlah_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrdmlah_n_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlah_n_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlah_n_s64(create_random_svint64_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlah_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlah_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_lane_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrdmlsh_lane_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlsh_lane_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlsh_lane_s16::<0>(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_lane_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_lane_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrdmlsh_lane_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlsh_lane_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlsh_lane_s32::<0>(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrdmlsh_lane_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlsh_lane_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlsh_lane_s64::<0>(create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqrdmlsh_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlsh_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlsh_s8(create_random_svint8_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqrdmlsh_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlsh_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlsh_n_s8(create_random_svint8_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrdmlsh_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlsh_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlsh_s16(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrdmlsh_n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlsh_n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlsh_n_s16(create_random_svint16_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrdmlsh_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlsh_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlsh_s32(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrdmlsh_n_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlsh_n_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlsh_n_s32(create_random_svint32_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrdmlsh_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlsh_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlsh_s64(create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrdmlsh_n_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrdmlsh_n_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmlsh_n_s64(create_random_svint64_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmulh_lane_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrdmulh_lane_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svqrdmulh_lane_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmulh_lane_s16::<0>(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmulh_lane_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmulh_lane_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmulh_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrdmulh_lane_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svqrdmulh_lane_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmulh_lane_s32::<0>(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmulh_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmulh_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmulh_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrdmulh_lane_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svqrdmulh_lane_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmulh_lane_s64::<0>(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmulh_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmulh_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmulh_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqrdmulh_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svqrdmulh_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmulh_s8(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmulh_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmulh_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmulh_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqrdmulh_n_s8(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svqrdmulh_n_s8(create_svint8_t_from(1i8), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmulh_n_s8(create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmulh_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmulh_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmulh_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrdmulh_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svqrdmulh_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmulh_s16(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmulh_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmulh_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmulh_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrdmulh_n_s16(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svqrdmulh_n_s16(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmulh_n_s16(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmulh_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmulh_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmulh_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrdmulh_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svqrdmulh_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmulh_s32(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmulh_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmulh_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmulh_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrdmulh_n_s32(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svqrdmulh_n_s32(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmulh_n_s32(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmulh_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmulh_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmulh_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrdmulh_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svqrdmulh_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmulh_s64(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmulh_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmulh_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmulh_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrdmulh_n_s64(create_svint64_t_from(1i64), 2i64));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svqrdmulh_n_s64(create_svint64_t_from(1i64), 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrdmulh_n_s64(create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrdmulh_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrdmulh_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqrshl_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_s8_m(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqrshl_n_s8_m(create_svbool_t(), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_s8_m(create_svbool_t(), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_s8_m(create_svbool_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqrshl_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_s8_x(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqrshl_n_s8_x(create_svbool_t(), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_s8_x(create_svbool_t(), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_s8_x(create_svbool_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqrshl_s8_z(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_s8_z(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_s8_z(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqrshl_n_s8_z(create_svbool_t(), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_s8_z(create_svbool_t(), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_s8_z(create_svbool_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrshl_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_s16_m(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrshl_n_s16_m(create_svbool_t(), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_s16_m(create_svbool_t(), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_s16_m(create_svbool_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrshl_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_s16_x(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrshl_n_s16_x(create_svbool_t(), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_s16_x(create_svbool_t(), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_s16_x(create_svbool_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrshl_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_s16_z(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrshl_n_s16_z(create_svbool_t(), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_s16_z(create_svbool_t(), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_s16_z(create_svbool_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrshl_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_s32_m(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrshl_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_s32_m(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrshl_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_s32_x(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrshl_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_s32_x(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrshl_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_s32_z(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrshl_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_s32_z(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrshl_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_s64_m(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrshl_n_s64_m(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_s64_m(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_s64_m(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrshl_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_s64_x(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrshl_n_s64_x(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_s64_x(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_s64_x(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrshl_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_s64_z(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrshl_n_s64_z(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_s64_z(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_s64_z(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqrshl_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_u8_m(create_svbool_t(), create_random_svuint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_u8_m_impl() }
}
