#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_arm_shared_neon_vdupq_lane_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vdupq_lane_u8::<0>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_lane_u8::<0>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_lane_u8::<0>(create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_lane_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vdup_lane_s64::<0>(create_int64x1_t_from([1])));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vdup_lane_s64::<0>(create_int64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_lane_s64::<0>(create_random_int64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_lane_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vdup_lane_u64::<0>(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vdup_lane_u64::<0>(create_uint64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_lane_u64::<0>(create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_laneq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vdup_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 1.0]).map_err(|e| format!("{e} | call: vdup_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_laneq_f32::<0>(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vdup_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vdup_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_laneq_s32::<0>(create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_laneq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vdup_laneq_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vdup_laneq_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_laneq_u32::<0>(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_laneq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vdupq_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: vdupq_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_laneq_f32::<0>(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vdupq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_laneq_s32::<0>(create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_laneq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vdupq_laneq_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_laneq_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_laneq_u32::<0>(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_laneq_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vdup_laneq_p16::<0>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdup_laneq_p16::<0>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_laneq_p16::<0>(create_random_poly16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vdup_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdup_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_laneq_s16::<0>(create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_laneq_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vdup_laneq_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdup_laneq_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_laneq_u16::<0>(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_laneq_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vdupq_laneq_p16::<0>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_laneq_p16::<0>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_laneq_p16::<0>(create_random_poly16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vdupq_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_laneq_s16::<0>(create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_laneq_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vdupq_laneq_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_laneq_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_laneq_u16::<0>(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_laneq_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vdup_laneq_p8::<0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdup_laneq_p8::<0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_laneq_p8::<0>(create_random_poly8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_laneq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vdup_laneq_s8::<0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdup_laneq_s8::<0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_laneq_s8::<0>(create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_laneq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vdup_laneq_u8::<0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdup_laneq_u8::<0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_laneq_u8::<0>(create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_laneq_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vdupq_laneq_p8::<0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_laneq_p8::<0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_laneq_p8::<0>(create_random_poly8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_laneq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vdupq_laneq_s8::<0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_laneq_s8::<0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_laneq_s8::<0>(create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_laneq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vdupq_laneq_u8::<0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_laneq_u8::<0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_laneq_u8::<0>(create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_laneq_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vdup_laneq_s64::<0>(create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vdup_laneq_s64::<0>(create_int64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_laneq_s64::<0>(create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_laneq_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vdup_laneq_u64::<0>(create_uint64x2_t_from([1, 2])));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vdup_laneq_u64::<0>(create_uint64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_laneq_u64::<0>(create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_n_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vdup_n_f32(1.0f32));
        check_array_equality(&result, &[1.0, 1.0]).map_err(|e| format!("{e} | call: vdup_n_f32(1.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_n_f32(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_n_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vdup_n_p16(1u16));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdup_n_p16(1u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_n_p16(rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_n_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vdup_n_p8(1u8));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdup_n_p8(1u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_n_p8(rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_n_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vdup_n_s16(1i16));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdup_n_s16(1i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_n_s16(rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_n_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vdup_n_s32(1i32));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vdup_n_s32(1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_n_s32(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_n_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vdup_n_s64(1i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vdup_n_s64(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_n_s64(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_n_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vdup_n_s8(1i8));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdup_n_s8(1i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_n_s8(rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_n_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vdup_n_u16(1u16));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdup_n_u16(1u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_n_u16(rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_n_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vdup_n_u32(1u32));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vdup_n_u32(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_n_u32(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_n_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vdup_n_u64(1u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vdup_n_u64(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_n_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_n_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vdup_n_u8(1u8));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdup_n_u8(1u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_n_u8(rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_n_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vdupq_n_f32(1.0f32));
        check_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: vdupq_n_f32(1.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_n_f32(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_n_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vdupq_n_p16(1u16));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_n_p16(1u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_n_p16(rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_n_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vdupq_n_p8(1u8));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_n_p8(1u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_n_p8(rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_n_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vdupq_n_s16(1i16));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_n_s16(1i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_n_s16(rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_n_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vdupq_n_s32(1i32));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_n_s32(1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_n_s32(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_n_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vdupq_n_s64(1i64));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vdupq_n_s64(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_n_s64(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_n_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vdupq_n_s8(1i8));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_n_s8(1i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_n_s8(rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_n_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vdupq_n_u16(1u16));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_n_u16(1u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_n_u16(rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_n_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vdupq_n_u32(1u32));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_n_u32(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_n_u32(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_n_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vdupq_n_u64(1u64));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vdupq_n_u64(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_n_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_n_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vdupq_n_u8(1u8));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_n_u8(1u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_n_u8(rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_lane_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vdupq_lane_s64::<0>(create_int64x1_t_from([1])));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vdupq_lane_s64::<0>(create_int64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_lane_s64::<0>(create_random_int64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_lane_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vdupq_lane_u64::<0>(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vdupq_lane_u64::<0>(create_uint64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_lane_u64::<0>(create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_laneq_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vdupq_laneq_s64::<0>(create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vdupq_laneq_s64::<0>(create_int64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_laneq_s64::<0>(create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_laneq_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vdupq_laneq_u64::<0>(create_uint64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vdupq_laneq_u64::<0>(create_uint64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_laneq_u64::<0>(create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_veor_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(veor_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 8, 8, 8, 8, 8, 8, 24]).map_err(|e| format!("{e} | call: veor_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = veor_s8(create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}
