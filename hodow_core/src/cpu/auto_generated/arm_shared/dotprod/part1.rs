#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_arm_shared_dotprod_vdot_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vdot_lane_s32::<0>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[231, 432]).map_err(|e| format!("{e} | call: vdot_lane_s32::<0>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdot_lane_s32::<0>(create_random_int32x2_t(), create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_dotprod_vdotq_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vdotq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x8_t_from([21, 22, 23, 24, 25, 26, 27, 28])));
        check_array_equality(&result, &[591, 952, 1313, 1674]).map_err(|e| format!("{e} | call: vdotq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x8_t_from([21, 22, 23, 24, 25, 26, 27, 28]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdotq_lane_s32::<0>(create_random_int32x4_t(), create_random_int8x16_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_dotprod_vdot_lane_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vdot_lane_u32::<0>(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[231, 432]).map_err(|e| format!("{e} | call: vdot_lane_u32::<0>(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdot_lane_u32::<0>(create_random_uint32x2_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_dotprod_vdotq_lane_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vdotq_lane_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_uint8x8_t_from([21, 22, 23, 24, 25, 26, 27, 28])));
        check_array_equality(&result, &[591, 952, 1313, 1674]).map_err(|e| format!("{e} | call: vdotq_lane_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_uint8x8_t_from([21, 22, 23, 24, 25, 26, 27, 28]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdotq_lane_u32::<0>(create_random_uint32x4_t(), create_random_uint8x16_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_dotprod_vdot_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vdot_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26])));
        check_array_equality(&result, &[231, 432]).map_err(|e| format!("{e} | call: vdot_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdot_laneq_s32::<0>(create_random_int32x2_t(), create_random_int8x8_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_dotprod_vdotq_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vdotq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[591, 952, 1313, 1674]).map_err(|e| format!("{e} | call: vdotq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdotq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_dotprod_vdot_laneq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vdot_laneq_u32::<0>(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26])));
        check_array_equality(&result, &[231, 432]).map_err(|e| format!("{e} | call: vdot_laneq_u32::<0>(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdot_laneq_u32::<0>(create_random_uint32x2_t(), create_random_uint8x8_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_dotprod_vdotq_laneq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vdotq_laneq_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_uint8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[591, 952, 1313, 1674]).map_err(|e| format!("{e} | call: vdotq_laneq_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_uint8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdotq_laneq_u32::<0>(create_random_uint32x4_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_dotprod_vdot_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vdot_s32(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[231, 568]).map_err(|e| format!("{e} | call: vdot_s32(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdot_s32(create_random_int32x2_t(), create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_dotprod_vdotq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vdotq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[591, 1120, 1777, 2562]).map_err(|e| format!("{e} | call: vdotq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdotq_s32(create_random_int32x4_t(), create_random_int8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_dotprod_vdot_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vdot_u32(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[231, 568]).map_err(|e| format!("{e} | call: vdot_u32(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdot_u32(create_random_uint32x2_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_dotprod_vdotq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vdotq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_uint8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[591, 1120, 1777, 2562]).map_err(|e| format!("{e} | call: vdotq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_uint8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdotq_u32(create_random_uint32x4_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}
