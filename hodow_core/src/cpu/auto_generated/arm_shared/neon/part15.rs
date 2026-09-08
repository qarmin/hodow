#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_arm_shared_neon_vmls_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vmls_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-14, -18]).map_err(|e| format!("{e} | call: vmls_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmls_laneq_s32::<0>(create_random_int32x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmls_laneq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vmls_laneq_u32::<0>(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4294967282, 4294967278]).map_err(|e| format!("{e} | call: vmls_laneq_u32::<0>(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmls_laneq_u32::<0>(create_random_uint32x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x2_t_from([9, 10])));
        check_array_equality(&result, &[-44, -52, -60, -68]).map_err(|e| format!("{e} | call: vmlsq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x2_t_from([9, 10]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsq_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_lane_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x2_t_from([9, 10])));
        check_array_equality(&result, &[4294967252, 4294967244, 4294967236, 4294967228]).map_err(|e| format!("{e} | call: vmlsq_lane_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x2_t_from([9, 10]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsq_lane_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-44, -52, -60, -68]).map_err(|e| format!("{e} | call: vmlsq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_laneq_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[4294967252, 4294967244, 4294967236, 4294967228]).map_err(|e| format!("{e} | call: vmlsq_laneq_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsq_laneq_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmls_n_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vmls_n_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]), 5.0f32));
        check_array_equality(&result, &[-14.0, -18.0]).map_err(|e| format!("{e} | call: vmls_n_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]), 5.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmls_n_f32(create_random_float32x2_t(), create_random_float32x2_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsq_n_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_n_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), 9.0f32));
        check_array_equality(&result, &[-44.0, -52.0, -60.0, -68.0]).map_err(|e| format!("{e} | call: vmlsq_n_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), 9.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsq_n_f32(create_random_float32x4_t(), create_random_float32x4_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmls_n_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vmls_n_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[-44, -52, -60, -68]).map_err(|e| format!("{e} | call: vmls_n_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), 9i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmls_n_s16(create_random_int16x4_t(), create_random_int16x4_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_n_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), 17i16));
        check_array_equality(&result, &[-152, -168, -184, -200, -216, -232, -248, -264]).map_err(|e| format!("{e} | call: vmlsq_n_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), 17i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsq_n_s16(create_random_int16x8_t(), create_random_int16x8_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmls_n_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vmls_n_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), 9u16));
        check_array_equality(&result, &[65492, 65484, 65476, 65468]).map_err(|e| format!("{e} | call: vmls_n_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), 9u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmls_n_u16(create_random_uint16x4_t(), create_random_uint16x4_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_n_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), 17u16));
        check_array_equality(&result, &[65384, 65368, 65352, 65336, 65320, 65304, 65288, 65272]).map_err(|e| format!("{e} | call: vmlsq_n_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), 17u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsq_n_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmls_n_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vmls_n_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), 5i32));
        check_array_equality(&result, &[-14, -18]).map_err(|e| format!("{e} | call: vmls_n_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), 5i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmls_n_s32(create_random_int32x2_t(), create_random_int32x2_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_n_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), 9i32));
        check_array_equality(&result, &[-44, -52, -60, -68]).map_err(|e| format!("{e} | call: vmlsq_n_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), 9i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsq_n_s32(create_random_int32x4_t(), create_random_int32x4_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmls_n_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vmls_n_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), 5u32));
        check_array_equality(&result, &[4294967282, 4294967278]).map_err(|e| format!("{e} | call: vmls_n_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), 5u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmls_n_u32(create_random_uint32x2_t(), create_random_uint32x2_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_n_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), 9u32));
        check_array_equality(&result, &[4294967252, 4294967244, 4294967236, 4294967228]).map_err(|e| format!("{e} | call: vmlsq_n_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), 9u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsq_n_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmls_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vmls_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[104, 78, 50, 20, -12, -46, -82, -120]).map_err(|e| format!("{e} | call: vmls_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmls_s8(create_random_int8x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vmlsq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create_int8x16_t_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[-48, -98, 106, 52, -4, -62, -122, 72, 8, -58, -126, 60, -12, -86, 94, 16]).map_err(|e| format!("{e} | call: vmlsq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create_int8x16_t_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsq_s8(create_random_int8x16_t(), create_random_int8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmls_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vmls_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-44, -58, -74, -92]).map_err(|e| format!("{e} | call: vmls_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmls_s16(create_random_int16x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-152, -178, -206, -236, -268, -302, -338, -376]).map_err(|e| format!("{e} | call: vmlsq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsq_s16(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmls_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vmls_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[-14, -22]).map_err(|e| format!("{e} | call: vmls_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmls_s32(create_random_int32x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-44, -58, -74, -92]).map_err(|e| format!("{e} | call: vmlsq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsq_s32(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmls_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vmls_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[104, 78, 50, 20, 244, 210, 174, 136]).map_err(|e| format!("{e} | call: vmls_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmls_u8(create_random_uint8x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vmlsq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create_uint8x16_t_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[208, 158, 106, 52, 252, 194, 134, 72, 8, 198, 130, 60, 244, 170, 94, 16]).map_err(|e| format!("{e} | call: vmlsq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create_uint8x16_t_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsq_u8(create_random_uint8x16_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmls_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vmls_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[65492, 65478, 65462, 65444]).map_err(|e| format!("{e} | call: vmls_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmls_u16(create_random_uint16x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsq_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[65384, 65358, 65330, 65300, 65268, 65234, 65198, 65160]).map_err(|e| format!("{e} | call: vmlsq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsq_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmls_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vmls_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[4294967282, 4294967274]).map_err(|e| format!("{e} | call: vmls_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmls_u32(create_random_uint32x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[4294967252, 4294967238, 4294967222, 4294967204]).map_err(|e| format!("{e} | call: vmlsq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsq_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_lane_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-44, -52, -60, -68]).map_err(|e| format!("{e} | call: vmlsl_lane_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_laneq_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-44, -52, -60, -68]).map_err(|e| format!("{e} | call: vmlsl_laneq_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_lane_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[-14, -18]).map_err(|e| format!("{e} | call: vmlsl_lane_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_laneq_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-14, -18]).map_err(|e| format!("{e} | call: vmlsl_laneq_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_lane_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[4294967252, 4294967244, 4294967236, 4294967228]).map_err(|e| format!("{e} | call: vmlsl_lane_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_laneq_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967252, 4294967244, 4294967236, 4294967228]).map_err(|e| format!("{e} | call: vmlsl_laneq_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_lane_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[18446744073709551602, 18446744073709551598]).map_err(|e| format!("{e} | call: vmlsl_lane_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_laneq_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551602, 18446744073709551598]).map_err(|e| format!("{e} | call: vmlsl_laneq_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsl_n_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_n_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[-44, -52, -60, -68]).map_err(|e| format!("{e} | call: vmlsl_n_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), 9i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_n_s16(create_random_int32x4_t(), create_random_int16x4_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsl_n_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_n_s32(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), 5i32));
        check_array_equality(&result, &[-14, -18]).map_err(|e| format!("{e} | call: vmlsl_n_s32(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), 5i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_n_s32(create_random_int64x2_t(), create_random_int32x2_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsl_n_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_n_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), 9u16));
        check_array_equality(&result, &[4294967252, 4294967244, 4294967236, 4294967228]).map_err(|e| format!("{e} | call: vmlsl_n_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), 9u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_n_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsl_n_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_n_u32(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), 5u32));
        check_array_equality(&result, &[18446744073709551602, 18446744073709551598]).map_err(|e| format!("{e} | call: vmlsl_n_u32(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), 5u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_n_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsl_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsl_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-152, -178, -206, -236, -268, -302, -338, -376]).map_err(|e| format!("{e} | call: vmlsl_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_s8(create_random_int16x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsl_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-44, -58, -74, -92]).map_err(|e| format!("{e} | call: vmlsl_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_s16(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsl_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_s32(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[-14, -22]).map_err(|e| format!("{e} | call: vmlsl_s32(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_s32(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsl_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsl_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[65384, 65358, 65330, 65300, 65268, 65234, 65198, 65160]).map_err(|e| format!("{e} | call: vmlsl_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_u8(create_random_uint16x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsl_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[4294967252, 4294967238, 4294967222, 4294967204]).map_err(|e| format!("{e} | call: vmlsl_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmlsl_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_u32(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[18446744073709551602, 18446744073709551594]).map_err(|e| format!("{e} | call: vmlsl_u32(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmlsl_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmmlaq_s32() -> Result<(), String> {
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

pub(super) fn test_arm_shared_neon_vmmlaq_u32() -> Result<(), String> {
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

pub(super) fn test_arm_shared_neon_vmov_n_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vmov_n_f32(1.0f32));
        check_array_equality(&result, &[1.0, 1.0]).map_err(|e| format!("{e} | call: vmov_n_f32(1.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmov_n_f32(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmov_n_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vmov_n_p16(1u16));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vmov_n_p16(1u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmov_n_p16(rand::random::<u16>());
            }
        }
    }
    Ok(())
}
