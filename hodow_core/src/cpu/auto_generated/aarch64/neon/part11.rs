use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_neon_vmlal_high_n_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_n_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), 13i16));
        check_array_equality(&result, &[118, 132, 146, 160]).map_err(|e| format!("{e} | call: vmlal_high_n_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), 13i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlal_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlal_high_n_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_n_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), 7i32));
        check_array_equality(&result, &[36, 44]).map_err(|e| format!("{e} | call: vmlal_high_n_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), 7i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlal_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlal_high_n_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_n_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), 13u16));
        check_array_equality(&result, &[118, 132, 146, 160]).map_err(|e| format!("{e} | call: vmlal_high_n_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), 13u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlal_high_n_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlal_high_n_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_n_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), 7u32));
        check_array_equality(&result, &[36, 44]).map_err(|e| format!("{e} | call: vmlal_high_n_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), 7u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlal_high_n_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlal_high_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlal_high_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_int8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40])));
        check_array_equality(&result, &[562, 614, 668, 724, 782, 842, 904, 968]).map_err(|e| format!("{e} | call: vmlal_high_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_int8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlal_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlal_high_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[154, 182, 212, 244]).map_err(|e| format!("{e} | call: vmlal_high_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlal_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlal_high_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[46, 62]).map_err(|e| format!("{e} | call: vmlal_high_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlal_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlal_high_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlal_high_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_uint8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40])));
        check_array_equality(&result, &[562, 614, 668, 724, 782, 842, 904, 968]).map_err(|e| format!("{e} | call: vmlal_high_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_uint8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlal_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlal_high_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[154, 182, 212, 244]).map_err(|e| format!("{e} | call: vmlal_high_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlal_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlal_high_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[46, 62]).map_err(|e| format!("{e} | call: vmlal_high_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlal_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmls_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vmls_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]), create_float64x1_t_from([3.0])));
        check_array_equality(&result, &[-5.0]).map_err(|e| format!("{e} | call: vmls_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]), create_float64x1_t_from([3.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmls_f64(create_random_float64x1_t(), create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vmlsq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), create_float64x2_t_from([5.0, 6.0])));
        check_array_equality(&result, &[-14.0, -22.0]).map_err(|e| format!("{e} | call: vmlsq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), create_float64x2_t_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsq_f64(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_lane_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16])));
        check_array_equality(&result, &[-116, -128, -140, -152]).map_err(|e| format!("{e} | call: vmlsl_high_lane_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_laneq_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[-116, -128, -140, -152]).map_err(|e| format!("{e} | call: vmlsl_high_laneq_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_lane_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x2_t_from([7, 8])));
        check_array_equality(&result, &[-34, -40]).map_err(|e| format!("{e} | call: vmlsl_high_lane_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x2_t_from([7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_laneq_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[-34, -40]).map_err(|e| format!("{e} | call: vmlsl_high_laneq_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_lane_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x4_t_from([13, 14, 15, 16])));
        check_array_equality(&result, &[4294967180, 4294967168, 4294967156, 4294967144]).map_err(|e| format!("{e} | call: vmlsl_high_lane_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x4_t_from([13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_high_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_laneq_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[4294967180, 4294967168, 4294967156, 4294967144]).map_err(|e| format!("{e} | call: vmlsl_high_laneq_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_high_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_lane_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x2_t_from([7, 8])));
        check_array_equality(&result, &[18446744073709551582, 18446744073709551576]).map_err(|e| format!("{e} | call: vmlsl_high_lane_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x2_t_from([7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_high_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_laneq_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[18446744073709551582, 18446744073709551576]).map_err(|e| format!("{e} | call: vmlsl_high_laneq_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_high_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_n_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), 13i16));
        check_array_equality(&result, &[-116, -128, -140, -152]).map_err(|e| format!("{e} | call: vmlsl_high_n_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), 13i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_n_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), 7i32));
        check_array_equality(&result, &[-34, -40]).map_err(|e| format!("{e} | call: vmlsl_high_n_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), 7i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_n_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), 13u16));
        check_array_equality(&result, &[4294967180, 4294967168, 4294967156, 4294967144]).map_err(|e| format!("{e} | call: vmlsl_high_n_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), 13u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_high_n_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_n_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), 7u32));
        check_array_equality(&result, &[18446744073709551582, 18446744073709551576]).map_err(|e| format!("{e} | call: vmlsl_high_n_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), 7u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_high_n_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsl_high_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsl_high_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_int8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40])));
        check_array_equality(&result, &[-560, -610, -662, -716, -772, -830, -890, -952]).map_err(|e| format!("{e} | call: vmlsl_high_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_int8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsl_high_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[-152, -178, -206, -236]).map_err(|e| format!("{e} | call: vmlsl_high_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsl_high_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[-44, -58]).map_err(|e| format!("{e} | call: vmlsl_high_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsl_high_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsl_high_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_uint8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40])));
        check_array_equality(&result, &[64976, 64926, 64874, 64820, 64764, 64706, 64646, 64584]).map_err(|e| format!("{e} | call: vmlsl_high_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_uint8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsl_high_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[4294967144, 4294967118, 4294967090, 4294967060]).map_err(|e| format!("{e} | call: vmlsl_high_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmlsl_high_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[18446744073709551572, 18446744073709551558]).map_err(|e| format!("{e} | call: vmlsl_high_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmovl_high_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmovl_high_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vmovl_high_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovl_high_s8(create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmovl_high_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmovl_high_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[5, 6, 7, 8]).map_err(|e| format!("{e} | call: vmovl_high_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovl_high_s16(create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmovl_high_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmovl_high_s32(create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[3, 4]).map_err(|e| format!("{e} | call: vmovl_high_s32(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovl_high_s32(create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmovl_high_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmovl_high_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vmovl_high_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovl_high_u8(create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmovl_high_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmovl_high_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[5, 6, 7, 8]).map_err(|e| format!("{e} | call: vmovl_high_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovl_high_u16(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmovl_high_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmovl_high_u32(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[3, 4]).map_err(|e| format!("{e} | call: vmovl_high_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovl_high_u32(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmovn_high_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vmovn_high_s16(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vmovn_high_s16(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovn_high_s16(create_random_int8x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmovn_high_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmovn_high_s32(create_int16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vmovn_high_s32(create_int16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovn_high_s32(create_random_int16x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmovn_high_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmovn_high_s64(create_int32x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vmovn_high_s64(create_int32x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovn_high_s64(create_random_int32x2_t(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmovn_high_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vmovn_high_u16(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vmovn_high_u16(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovn_high_u16(create_random_uint8x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmovn_high_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmovn_high_u32(create_uint16x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vmovn_high_u32(create_uint16x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovn_high_u32(create_random_uint16x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmovn_high_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmovn_high_u64(create_uint32x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vmovn_high_u64(create_uint32x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovn_high_u64(create_random_uint32x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmul_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vmul_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0])));
        check_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: vmul_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmul_f64(create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmulq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vmulq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[3.0, 8.0]).map_err(|e| format!("{e} | call: vmulq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmulq_f64(create_random_float64x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmul_lane_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vmul_lane_f64::<0>(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0])));
        check_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: vmul_lane_f64::<0>(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmul_lane_f64::<0>(create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmul_laneq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vmul_laneq_f64::<0>(create_float64x1_t_from([1.0]), create_float64x2_t_from([2.0, 3.0])));
        check_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: vmul_laneq_f64::<0>(create_float64x1_t_from([1.0]), create_float64x2_t_from([2.0, 3.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmul_laneq_f64::<0>(create_random_float64x1_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmul_n_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vmul_n_f64(create_float64x1_t_from([1.0]), 2.0f64));
        check_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: vmul_n_f64(create_float64x1_t_from([1.0]), 2.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmul_n_f64(create_random_float64x1_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmulq_n_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vmulq_n_f64(create_float64x2_t_from([1.0, 2.0]), 3.0f64));
        check_array_equality(&result, &[3.0, 6.0]).map_err(|e| format!("{e} | call: vmulq_n_f64(create_float64x2_t_from([1.0, 2.0]), 3.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmulq_n_f64(create_random_float64x2_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmuld_lane_f64() -> Result<(), String> {
    unsafe {
        let _result = vmuld_lane_f64::<0>(1.0f64, create_float64x1_t_from([2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmuld_lane_f64::<0>(rand::random::<f64>(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmull_high_lane_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmull_high_lane_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[45, 54, 63, 72]).map_err(|e| format!("{e} | call: vmull_high_lane_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmull_high_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}
