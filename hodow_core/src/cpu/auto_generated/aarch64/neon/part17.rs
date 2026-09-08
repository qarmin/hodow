use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_neon_vqdmull_high_n_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_n_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[90, 108, 126, 144]).map_err(|e| format!("{e} | call: vqdmull_high_n_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqdmull_high_n_s16(create_random_int16x8_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqdmull_high_n_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_n_s32(create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[30, 40]).map_err(|e| format!("{e} | call: vqdmull_high_n_s32(create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqdmull_high_n_s32(create_random_int32x4_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqdmull_high_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[130, 168, 210, 256]).map_err(|e| format!("{e} | call: vqdmull_high_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqdmull_high_s16(create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqdmull_high_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[42, 64]).map_err(|e| format!("{e} | call: vqdmull_high_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqdmull_high_s32(create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_laneq_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[10, 20, 30, 40]).map_err(|e| format!("{e} | call: vqdmull_laneq_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqdmull_laneq_s16::<0>(create_random_int16x4_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[6, 12]).map_err(|e| format!("{e} | call: vqdmull_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqdmull_laneq_s32::<0>(create_random_int32x2_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqdmullh_lane_s16() -> Result<(), String> {
    unsafe {
        let result = vqdmullh_lane_s16::<0>(1i16, create_int16x4_t_from([2, 3, 4, 5]));
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqdmullh_lane_s16::<0>(1i16, create_int16x4_t_from([2, 3, 4, 5]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqdmullh_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqdmulls_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = vqdmulls_laneq_s32::<0>(1i32, create_int32x4_t_from([2, 3, 4, 5]));
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqdmulls_laneq_s32::<0>(1i32, create_int32x4_t_from([2, 3, 4, 5]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqdmulls_laneq_s32::<0>(rand::random::<i32>(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqdmullh_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = vqdmullh_laneq_s16::<0>(1i16, create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]));
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqdmullh_laneq_s16::<0>(1i16, create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqdmullh_laneq_s16::<0>(rand::random::<i16>(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqdmullh_s16() -> Result<(), String> {
    unsafe {
        let result = vqdmullh_s16(1i16, 2i16);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqdmullh_s16(1i16, 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqdmullh_s16(rand::random::<i16>(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqdmulls_lane_s32() -> Result<(), String> {
    unsafe {
        let result = vqdmulls_lane_s32::<0>(1i32, create_int32x2_t_from([2, 3]));
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqdmulls_lane_s32::<0>(1i32, create_int32x2_t_from([2, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqdmulls_lane_s32::<0>(rand::random::<i32>(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqdmulls_s32() -> Result<(), String> {
    unsafe {
        let result = vqdmulls_s32(1i32, 2i32);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqdmulls_s32(1i32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqdmulls_s32(rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqmovn_high_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vqmovn_high_s16(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vqmovn_high_s16(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqmovn_high_s16(create_random_int8x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqmovn_high_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqmovn_high_s32(create_int16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vqmovn_high_s32(create_int16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqmovn_high_s32(create_random_int16x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqmovn_high_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqmovn_high_s64(create_int32x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vqmovn_high_s64(create_int32x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqmovn_high_s64(create_random_int32x2_t(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqmovn_high_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vqmovn_high_u16(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vqmovn_high_u16(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqmovn_high_u16(create_random_uint8x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqmovn_high_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vqmovn_high_u32(create_uint16x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vqmovn_high_u32(create_uint16x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqmovn_high_u32(create_random_uint16x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqmovn_high_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vqmovn_high_u64(create_uint32x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vqmovn_high_u64(create_uint32x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqmovn_high_u64(create_random_uint32x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqmovnd_s64() -> Result<(), String> {
    unsafe {
        let result = vqmovnd_s64(1i64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqmovnd_s64(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqmovnd_s64(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqmovnd_u64() -> Result<(), String> {
    unsafe {
        let result = vqmovnd_u64(1u64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqmovnd_u64(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqmovnd_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqmovnh_s16() -> Result<(), String> {
    unsafe {
        let result = vqmovnh_s16(1i16);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqmovnh_s16(1i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqmovnh_s16(rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqmovns_s32() -> Result<(), String> {
    unsafe {
        let result = vqmovns_s32(1i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqmovns_s32(1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqmovns_s32(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqmovnh_u16() -> Result<(), String> {
    unsafe {
        let result = vqmovnh_u16(1u16);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqmovnh_u16(1u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqmovnh_u16(rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqmovns_u32() -> Result<(), String> {
    unsafe {
        let result = vqmovns_u32(1u32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqmovns_u32(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqmovns_u32(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqmovun_high_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vqmovun_high_s16(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vqmovun_high_s16(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqmovun_high_s16(create_random_uint8x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqmovun_high_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vqmovun_high_s32(create_uint16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vqmovun_high_s32(create_uint16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqmovun_high_s32(create_random_uint16x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqmovun_high_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vqmovun_high_s64(create_uint32x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vqmovun_high_s64(create_uint32x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqmovun_high_s64(create_random_uint32x2_t(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqmovunh_s16() -> Result<(), String> {
    unsafe {
        let result = vqmovunh_s16(1i16);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqmovunh_s16(1i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqmovunh_s16(rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqmovuns_s32() -> Result<(), String> {
    unsafe {
        let result = vqmovuns_s32(1i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqmovuns_s32(1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqmovuns_s32(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqmovund_s64() -> Result<(), String> {
    unsafe {
        let result = vqmovund_s64(1i64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqmovund_s64(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqmovund_s64(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqneg_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vqneg_s64(create_int64x1_t_from([1])));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: vqneg_s64(create_int64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqneg_s64(create_random_int64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqnegq_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqnegq_s64(create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[-1, -2]).map_err(|e| format!("{e} | call: vqnegq_s64(create_int64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqnegq_s64(create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqnegb_s8() -> Result<(), String> {
    unsafe {
        let result = vqnegb_s8(1i8);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vqnegb_s8(1i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqnegb_s8(rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqnegh_s16() -> Result<(), String> {
    unsafe {
        let result = vqnegh_s16(1i16);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vqnegh_s16(1i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqnegh_s16(rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqnegs_s32() -> Result<(), String> {
    unsafe {
        let result = vqnegs_s32(1i32);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vqnegs_s32(1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqnegs_s32(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqnegd_s64() -> Result<(), String> {
    unsafe {
        let result = vqnegd_s64(1i64);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vqnegd_s64(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqnegd_s64(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlah_lane_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vqrdmlah_lane_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vqrdmlah_lane_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlah_lane_s16::<0>(create_random_int16x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlah_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vqrdmlah_lane_s32::<0>(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vqrdmlah_lane_s32::<0>(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlah_lane_s32::<0>(create_random_int32x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlah_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vqrdmlah_laneq_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vqrdmlah_laneq_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlah_laneq_s16::<0>(create_random_int16x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlah_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vqrdmlah_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vqrdmlah_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlah_laneq_s32::<0>(create_random_int32x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlahq_lane_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqrdmlahq_lane_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x4_t_from([17, 18, 19, 20])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vqrdmlahq_lane_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x4_t_from([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlahq_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlahq_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqrdmlahq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x2_t_from([9, 10])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vqrdmlahq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x2_t_from([9, 10]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlahq_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlahq_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqrdmlahq_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vqrdmlahq_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlahq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlahq_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqrdmlahq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vqrdmlahq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlahq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlah_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vqrdmlah_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vqrdmlah_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlah_s16(create_random_int16x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlahq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqrdmlahq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vqrdmlahq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlahq_s16(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlah_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vqrdmlah_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vqrdmlah_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlah_s32(create_random_int32x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlahq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqrdmlahq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vqrdmlahq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlahq_s32(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlahh_lane_s16() -> Result<(), String> {
    unsafe {
        let result = vqrdmlahh_lane_s16::<0>(1i16, 2i16, create_int16x4_t_from([3, 4, 5, 6]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrdmlahh_lane_s16::<0>(1i16, 2i16, create_int16x4_t_from([3, 4, 5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlahh_lane_s16::<0>(rand::random::<i16>(), rand::random::<i16>(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrdmlahh_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = vqrdmlahh_laneq_s16::<0>(1i16, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrdmlahh_laneq_s16::<0>(1i16, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrdmlahh_laneq_s16::<0>(rand::random::<i16>(), rand::random::<i16>(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}
