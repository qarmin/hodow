#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_arm_shared_i8mm_vmmlaq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmmlaq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[1709, 2254, 3279, 4336]).map_err(|e| format!("{e} | call: vmmlaq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmmlaq_s32(create_random_int32x4_t(), create_random_int8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_i8mm_vmmlaq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmmlaq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_uint8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[1709, 2254, 3279, 4336]).map_err(|e| format!("{e} | call: vmmlaq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_uint8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmmlaq_u32(create_random_uint32x4_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_i8mm_vsudot_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vsudot_lane_s32::<0>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[231, 432]).map_err(|e| format!("{e} | call: vsudot_lane_s32::<0>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsudot_lane_s32::<0>(create_random_int32x2_t(), create_random_int8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_i8mm_vsudotq_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsudotq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_uint8x8_t_from([21, 22, 23, 24, 25, 26, 27, 28])));
        check_array_equality(&result, &[591, 952, 1313, 1674]).map_err(|e| format!("{e} | call: vsudotq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_uint8x8_t_from([21, 22, 23, 24, 25, 26, 27, 28]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsudotq_lane_s32::<0>(create_random_int32x4_t(), create_random_int8x16_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_i8mm_vsudot_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vsudot_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26])));
        check_array_equality(&result, &[231, 432]).map_err(|e| format!("{e} | call: vsudot_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsudot_laneq_s32::<0>(create_random_int32x2_t(), create_random_int8x8_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_i8mm_vsudotq_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsudotq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_uint8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[591, 952, 1313, 1674]).map_err(|e| format!("{e} | call: vsudotq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_uint8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsudotq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_i8mm_vusdot_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vusdot_lane_s32::<0>(create_int32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[231, 432]).map_err(|e| format!("{e} | call: vusdot_lane_s32::<0>(create_int32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vusdot_lane_s32::<0>(create_random_int32x2_t(), create_random_uint8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_i8mm_vusdotq_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vusdotq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x8_t_from([21, 22, 23, 24, 25, 26, 27, 28])));
        check_array_equality(&result, &[591, 952, 1313, 1674]).map_err(|e| format!("{e} | call: vusdotq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x8_t_from([21, 22, 23, 24, 25, 26, 27, 28]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vusdotq_lane_s32::<0>(create_random_int32x4_t(), create_random_uint8x16_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_i8mm_vusdot_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vusdot_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26])));
        check_array_equality(&result, &[231, 432]).map_err(|e| format!("{e} | call: vusdot_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vusdot_laneq_s32::<0>(create_random_int32x2_t(), create_random_uint8x8_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_i8mm_vusdotq_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vusdotq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[591, 952, 1313, 1674]).map_err(|e| format!("{e} | call: vusdotq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vusdotq_laneq_s32::<0>(create_random_int32x4_t(), create_random_uint8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_i8mm_vusdot_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vusdot_s32(create_int32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[231, 568]).map_err(|e| format!("{e} | call: vusdot_s32(create_int32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vusdot_s32(create_random_int32x2_t(), create_random_uint8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_i8mm_vusdotq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vusdotq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[591, 1120, 1777, 2562]).map_err(|e| format!("{e} | call: vusdotq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vusdotq_s32(create_random_int32x4_t(), create_random_uint8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_i8mm_vusmmlaq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vusmmlaq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[1709, 2254, 3279, 4336]).map_err(|e| format!("{e} | call: vusmmlaq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vusmmlaq_s32(create_random_int32x4_t(), create_random_uint8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}
