use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_neon_vqrdmlahs_lane_s32() -> Result<(), String> {
    unsafe {
        let result = vqrdmlahs_lane_s32::<0>(1i32, 2i32, create_int32x2_t_from([3, 4]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrdmlahs_lane_s32::<0>(1i32, 2i32, create_int32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlahs_lane_s32::<0>(rand::random::<i32>(), rand::random::<i32>(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlahs_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = vqrdmlahs_laneq_s32::<0>(1i32, 2i32, create_int32x4_t_from([3, 4, 5, 6]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrdmlahs_laneq_s32::<0>(1i32, 2i32, create_int32x4_t_from([3, 4, 5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlahs_laneq_s32::<0>(rand::random::<i32>(), rand::random::<i32>(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlahh_s16() -> Result<(), String> {
    unsafe {
        let result = vqrdmlahh_s16(1i16, 2i16, 3i16);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrdmlahh_s16(1i16, 2i16, 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlahh_s16(rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlahs_s32() -> Result<(), String> {
    unsafe {
        let result = vqrdmlahs_s32(1i32, 2i32, 3i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrdmlahs_s32(1i32, 2i32, 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlahs_s32(rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlsh_lane_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vqrdmlsh_lane_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vqrdmlsh_lane_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlsh_lane_s16::<0>(create_random_int16x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlsh_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vqrdmlsh_lane_s32::<0>(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vqrdmlsh_lane_s32::<0>(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlsh_lane_s32::<0>(create_random_int32x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlsh_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vqrdmlsh_laneq_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vqrdmlsh_laneq_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlsh_laneq_s16::<0>(create_random_int16x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlsh_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vqrdmlsh_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vqrdmlsh_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlsh_laneq_s32::<0>(create_random_int32x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlshq_lane_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqrdmlshq_lane_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x4_t_from([17, 18, 19, 20])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vqrdmlshq_lane_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x4_t_from([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlshq_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlshq_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqrdmlshq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x2_t_from([9, 10])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vqrdmlshq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x2_t_from([9, 10]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlshq_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlshq_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqrdmlshq_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vqrdmlshq_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlshq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlshq_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqrdmlshq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vqrdmlshq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlshq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlsh_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vqrdmlsh_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vqrdmlsh_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlsh_s16(create_random_int16x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlshq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqrdmlshq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vqrdmlshq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlshq_s16(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlsh_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vqrdmlsh_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vqrdmlsh_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlsh_s32(create_random_int32x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlshq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqrdmlshq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vqrdmlshq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlshq_s32(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlshh_lane_s16() -> Result<(), String> {
    unsafe {
        let result = vqrdmlshh_lane_s16::<0>(1i16, 2i16, create_int16x4_t_from([3, 4, 5, 6]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrdmlshh_lane_s16::<0>(1i16, 2i16, create_int16x4_t_from([3, 4, 5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlshh_lane_s16::<0>(rand::random::<i16>(), rand::random::<i16>(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlshh_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = vqrdmlshh_laneq_s16::<0>(1i16, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrdmlshh_laneq_s16::<0>(1i16, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlshh_laneq_s16::<0>(rand::random::<i16>(), rand::random::<i16>(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlshs_lane_s32() -> Result<(), String> {
    unsafe {
        let result = vqrdmlshs_lane_s32::<0>(1i32, 2i32, create_int32x2_t_from([3, 4]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrdmlshs_lane_s32::<0>(1i32, 2i32, create_int32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlshs_lane_s32::<0>(rand::random::<i32>(), rand::random::<i32>(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlshs_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = vqrdmlshs_laneq_s32::<0>(1i32, 2i32, create_int32x4_t_from([3, 4, 5, 6]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrdmlshs_laneq_s32::<0>(1i32, 2i32, create_int32x4_t_from([3, 4, 5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlshs_laneq_s32::<0>(rand::random::<i32>(), rand::random::<i32>(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlshh_s16() -> Result<(), String> {
    unsafe {
        let result = vqrdmlshh_s16(1i16, 2i16, 3i16);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrdmlshh_s16(1i16, 2i16, 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlshh_s16(rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlshs_s32() -> Result<(), String> {
    unsafe {
        let result = vqrdmlshs_s32(1i32, 2i32, 3i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrdmlshs_s32(1i32, 2i32, 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlshs_s32(rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmulhh_lane_s16() -> Result<(), String> {
    unsafe {
        let result = vqrdmulhh_lane_s16::<0>(1i16, create_int16x4_t_from([2, 3, 4, 5]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqrdmulhh_lane_s16::<0>(1i16, create_int16x4_t_from([2, 3, 4, 5]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmulhh_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmulhh_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = vqrdmulhh_laneq_s16::<0>(1i16, create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqrdmulhh_laneq_s16::<0>(1i16, create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmulhh_laneq_s16::<0>(rand::random::<i16>(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmulhs_lane_s32() -> Result<(), String> {
    unsafe {
        let result = vqrdmulhs_lane_s32::<0>(1i32, create_int32x2_t_from([2, 3]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqrdmulhs_lane_s32::<0>(1i32, create_int32x2_t_from([2, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmulhs_lane_s32::<0>(rand::random::<i32>(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmulhs_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = vqrdmulhs_laneq_s32::<0>(1i32, create_int32x4_t_from([2, 3, 4, 5]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqrdmulhs_laneq_s32::<0>(1i32, create_int32x4_t_from([2, 3, 4, 5]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmulhs_laneq_s32::<0>(rand::random::<i32>(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmulhh_s16() -> Result<(), String> {
    unsafe {
        let result = vqrdmulhh_s16(1i16, 2i16);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqrdmulhh_s16(1i16, 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmulhh_s16(rand::random::<i16>(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmulhs_s32() -> Result<(), String> {
    unsafe {
        let result = vqrdmulhs_s32(1i32, 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqrdmulhs_s32(1i32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmulhs_s32(rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshlb_s8() -> Result<(), String> {
    unsafe {
        let result = vqrshlb_s8(1i8, 2i8);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqrshlb_s8(1i8, 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshlb_s8(rand::random::<i8>(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshlh_s16() -> Result<(), String> {
    unsafe {
        let result = vqrshlh_s16(1i16, 2i16);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqrshlh_s16(1i16, 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshlh_s16(rand::random::<i16>(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshlb_u8() -> Result<(), String> {
    unsafe {
        let result = vqrshlb_u8(1u8, 2i8);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqrshlb_u8(1u8, 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshlb_u8(rand::random::<u8>(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshlh_u16() -> Result<(), String> {
    unsafe {
        let result = vqrshlh_u16(1u16, 2i16);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqrshlh_u16(1u16, 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshlh_u16(rand::random::<u16>(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshld_s64() -> Result<(), String> {
    unsafe {
        let result = vqrshld_s64(1i64, 2i64);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqrshld_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshld_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshls_s32() -> Result<(), String> {
    unsafe {
        let result = vqrshls_s32(1i32, 2i32);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqrshls_s32(1i32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshls_s32(rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshls_u32() -> Result<(), String> {
    unsafe {
        let result = vqrshls_u32(1u32, 2i32);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqrshls_u32(1u32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshls_u32(rand::random::<u32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshld_u64() -> Result<(), String> {
    unsafe {
        let result = vqrshld_u64(1u64, 2i64);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqrshld_u64(1u64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshld_u64(rand::random::<u64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshrn_high_n_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vqrshrn_high_n_s16::<1>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 5, 5, 6, 6, 7, 7, 8, 8]).map_err(|e| format!("{e} | call: vqrshrn_high_n_s16::<1>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshrn_high_n_s16::<1>(create_random_int8x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshrn_high_n_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqrshrn_high_n_s32::<1>(create_int16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 3, 3, 4, 4]).map_err(|e| format!("{e} | call: vqrshrn_high_n_s32::<1>(create_int16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshrn_high_n_s32::<1>(create_random_int16x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshrn_high_n_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqrshrn_high_n_s64::<1>(create_int32x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2, 2, 2]).map_err(|e| format!("{e} | call: vqrshrn_high_n_s64::<1>(create_int32x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshrn_high_n_s64::<1>(create_random_int32x2_t(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshrn_high_n_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vqrshrn_high_n_u16::<1>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 5, 5, 6, 6, 7, 7, 8, 8]).map_err(|e| format!("{e} | call: vqrshrn_high_n_u16::<1>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshrn_high_n_u16::<1>(create_random_uint8x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshrn_high_n_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vqrshrn_high_n_u32::<1>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 3, 3, 4, 4]).map_err(|e| format!("{e} | call: vqrshrn_high_n_u32::<1>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshrn_high_n_u32::<1>(create_random_uint16x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshrn_high_n_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vqrshrn_high_n_u64::<1>(create_uint32x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2, 2, 2]).map_err(|e| format!("{e} | call: vqrshrn_high_n_u64::<1>(create_uint32x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshrn_high_n_u64::<1>(create_random_uint32x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshrnd_n_u64() -> Result<(), String> {
    unsafe {
        let result = vqrshrnd_n_u64::<1>(1u64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrshrnd_n_u64::<1>(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshrnd_n_u64::<1>(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshrnh_n_u16() -> Result<(), String> {
    unsafe {
        let result = vqrshrnh_n_u16::<1>(1u16);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrshrnh_n_u16::<1>(1u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshrnh_n_u16::<1>(rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshrns_n_u32() -> Result<(), String> {
    unsafe {
        let result = vqrshrns_n_u32::<1>(1u32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrshrns_n_u32::<1>(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshrns_n_u32::<1>(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshrnh_n_s16() -> Result<(), String> {
    unsafe {
        let result = vqrshrnh_n_s16::<1>(1i16);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrshrnh_n_s16::<1>(1i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshrnh_n_s16::<1>(rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshrns_n_s32() -> Result<(), String> {
    unsafe {
        let result = vqrshrns_n_s32::<1>(1i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrshrns_n_s32::<1>(1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshrns_n_s32::<1>(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshrnd_n_s64() -> Result<(), String> {
    unsafe {
        let result = vqrshrnd_n_s64::<1>(1i64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrshrnd_n_s64::<1>(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshrnd_n_s64::<1>(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vqrshrun_high_n_s16::<1>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 5, 5, 6, 6, 7, 7, 8, 8]).map_err(|e| format!("{e} | call: vqrshrun_high_n_s16::<1>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshrun_high_n_s16::<1>(create_random_uint8x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vqrshrun_high_n_s32::<1>(create_uint16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 3, 3, 4, 4]).map_err(|e| format!("{e} | call: vqrshrun_high_n_s32::<1>(create_uint16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshrun_high_n_s32::<1>(create_random_uint16x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}
