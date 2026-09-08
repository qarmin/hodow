use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqcadd_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqcadd_s16::<90>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqcadd_s16::<90>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqcadd_s16::<90>(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqcadd_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqcadd_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqcadd_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqcadd_s32::<90>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqcadd_s32::<90>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqcadd_s32::<90>(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqcadd_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqcadd_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqcadd_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqcadd_s64::<90>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqcadd_s64::<90>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqcadd_s64::<90>(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqcadd_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqcadd_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalb_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmlalb_lane_s32::<0>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalb_lane_s32::<0>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalb_lane_s32::<0>(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalb_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalb_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalb_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmlalb_lane_s64::<0>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalb_lane_s64::<0>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalb_lane_s64::<0>(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalb_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalb_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmlalb_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalb_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalb_s16(create_random_svint16_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmlalb_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalb_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalb_n_s16(create_random_svint16_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmlalb_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalb_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalb_s32(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmlalb_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalb_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalb_n_s32(create_random_svint32_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmlalb_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalb_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalb_s64(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmlalb_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalb_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalb_n_s64(create_random_svint64_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalbt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmlalbt_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalbt_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalbt_s16(create_random_svint16_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalbt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalbt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalbt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmlalbt_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalbt_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalbt_n_s16(create_random_svint16_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalbt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalbt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalbt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmlalbt_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalbt_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalbt_s32(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalbt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalbt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalbt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmlalbt_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalbt_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalbt_n_s32(create_random_svint32_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalbt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalbt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalbt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmlalbt_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalbt_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalbt_s64(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalbt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalbt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalbt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmlalbt_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalbt_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalbt_n_s64(create_random_svint64_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalbt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalbt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalt_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmlalt_lane_s32::<0>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalt_lane_s32::<0>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalt_lane_s32::<0>(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalt_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalt_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalt_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmlalt_lane_s64::<0>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalt_lane_s64::<0>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalt_lane_s64::<0>(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalt_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalt_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmlalt_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalt_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalt_s16(create_random_svint16_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmlalt_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalt_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalt_n_s16(create_random_svint16_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmlalt_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalt_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalt_s32(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmlalt_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalt_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalt_n_s32(create_random_svint32_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmlalt_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalt_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalt_s64(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlalt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmlalt_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svqdmlalt_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlalt_n_s64(create_random_svint64_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlalt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlalt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslb_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmlslb_lane_s32::<0>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslb_lane_s32::<0>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslb_lane_s32::<0>(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslb_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslb_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslb_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmlslb_lane_s64::<0>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslb_lane_s64::<0>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslb_lane_s64::<0>(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslb_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslb_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmlslb_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslb_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslb_s16(create_random_svint16_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmlslb_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslb_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslb_n_s16(create_random_svint16_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmlslb_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslb_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslb_s32(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmlslb_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslb_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslb_n_s32(create_random_svint32_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmlslb_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslb_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslb_s64(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmlslb_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslb_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslb_n_s64(create_random_svint64_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslbt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmlslbt_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslbt_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslbt_s16(create_random_svint16_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslbt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslbt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslbt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmlslbt_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslbt_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslbt_n_s16(create_random_svint16_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslbt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslbt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslbt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmlslbt_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslbt_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslbt_s32(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslbt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslbt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslbt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmlslbt_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslbt_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslbt_n_s32(create_random_svint32_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslbt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslbt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslbt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmlslbt_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslbt_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslbt_s64(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslbt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslbt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslbt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmlslbt_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslbt_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslbt_n_s64(create_random_svint64_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslbt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslbt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslt_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmlslt_lane_s32::<0>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslt_lane_s32::<0>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslt_lane_s32::<0>(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslt_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslt_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslt_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmlslt_lane_s64::<0>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslt_lane_s64::<0>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslt_lane_s64::<0>(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslt_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslt_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmlslt_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslt_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslt_s16(create_random_svint16_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmlslt_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslt_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslt_n_s16(create_random_svint16_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmlslt_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslt_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslt_s32(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmlslt_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslt_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslt_n_s32(create_random_svint32_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmlslt_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslt_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslt_s64(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmlslt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmlslt_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[-11]).map_err(|e| format!("{e} | call: svqdmlslt_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmlslt_n_s64(create_random_svint64_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmlslt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmlslt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmulh_lane_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqdmulh_lane_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svqdmulh_lane_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmulh_lane_s16::<0>(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmulh_lane_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmulh_lane_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmulh_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqdmulh_lane_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svqdmulh_lane_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmulh_lane_s32::<0>(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmulh_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmulh_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqdmulh_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqdmulh_lane_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svqdmulh_lane_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqdmulh_lane_s64::<0>(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqdmulh_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqdmulh_lane_s64_impl() }
}
