use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_neon_vcmla_rot270_laneq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcmla_rot270_laneq_f32::<0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[25.0, -18.0]).map_err(|e| format!("{e} | call: vcmla_rot270_laneq_f32::<0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcmla_rot270_laneq_f32::<0>(create_random_float32x2_t(), create_random_float32x2_t(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcmlaq_rot270_laneq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcmlaq_rot270_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0])));
        check_array_equality(&result, &[61.0, -52.0, 83.0, -68.0]).map_err(|e| format!("{e} | call: vcmlaq_rot270_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcmlaq_rot270_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcmla_rot90_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcmla_rot90_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]), create_float32x2_t_from([5.0, 6.0])));
        check_array_equality(&result, &[-23.0, 22.0]).map_err(|e| format!("{e} | call: vcmla_rot90_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]), create_float32x2_t_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcmla_rot90_f32(create_random_float32x2_t(), create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcmlaq_rot90_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcmlaq_rot90_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0])));
        check_array_equality(&result, &[-59.0, 56.0, -93.0, 92.0]).map_err(|e| format!("{e} | call: vcmlaq_rot90_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcmlaq_rot90_f32(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcmlaq_rot90_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcmlaq_rot90_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), create_float64x2_t_from([5.0, 6.0])));
        check_array_equality(&result, &[-23.0, 22.0]).map_err(|e| format!("{e} | call: vcmlaq_rot90_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), create_float64x2_t_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcmlaq_rot90_f64(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcmla_rot90_lane_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcmla_rot90_lane_f32::<0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]), create_float32x2_t_from([5.0, 6.0])));
        check_array_equality(&result, &[-23.0, 22.0]).map_err(|e| format!("{e} | call: vcmla_rot90_lane_f32::<0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]), create_float32x2_t_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcmla_rot90_lane_f32::<0>(create_random_float32x2_t(), create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcmlaq_rot90_lane_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcmlaq_rot90_lane_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x2_t_from([9.0, 10.0])));
        check_array_equality(&result, &[-59.0, 56.0, -77.0, 76.0]).map_err(|e| format!("{e} | call: vcmlaq_rot90_lane_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x2_t_from([9.0, 10.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcmlaq_rot90_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcmla_rot90_laneq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcmla_rot90_laneq_f32::<0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[-23.0, 22.0]).map_err(|e| format!("{e} | call: vcmla_rot90_laneq_f32::<0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcmla_rot90_laneq_f32::<0>(create_random_float32x2_t(), create_random_float32x2_t(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcmlaq_rot90_laneq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcmlaq_rot90_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0])));
        check_array_equality(&result, &[-59.0, 56.0, -77.0, 76.0]).map_err(|e| format!("{e} | call: vcmlaq_rot90_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcmlaq_rot90_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcombine_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcombine_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vcombine_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcombine_f64(create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_lane_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_lane_f32::<0, 0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[3.0, 2.0]).map_err(|e| format!("{e} | call: vcopy_lane_f32::<0, 0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_lane_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_lane_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_lane_s8::<0, 0>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vcopy_lane_s8::<0, 0>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_lane_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_lane_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_lane_s16::<0, 0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 2, 3, 4]).map_err(|e| format!("{e} | call: vcopy_lane_s16::<0, 0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_lane_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_lane_s32::<0, 0>(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 2]).map_err(|e| format!("{e} | call: vcopy_lane_s32::<0, 0>(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_lane_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_lane_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_lane_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_lane_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 2, 3, 4]).map_err(|e| format!("{e} | call: vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_lane_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_lane_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 2]).map_err(|e| format!("{e} | call: vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_lane_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_lane_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_lane_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_lane_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([1, 2, 3, 4]), create_poly16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 2, 3, 4]).map_err(|e| format!("{e} | call: vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([1, 2, 3, 4]), create_poly16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_lane_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_lane_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_lane_f64::<0, 0>(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0])));
        check_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: vcopy_lane_f64::<0, 0>(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_lane_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_lane_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_lane_s64::<0, 0>(create_int64x1_t_from([1]), create_int64x1_t_from([2])));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: vcopy_lane_s64::<0, 0>(create_int64x1_t_from([1]), create_int64x1_t_from([2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_lane_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_lane_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([1]), create_uint64x1_t_from([2])));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([1]), create_uint64x1_t_from([2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_lane_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_lane_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([1]), create_poly64x1_t_from([2])));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([1]), create_poly64x1_t_from([2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_lane_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([1.0, 2.0]), create_float32x4_t_from([3.0, 4.0, 5.0, 6.0])));
        check_array_equality(&result, &[3.0, 2.0]).map_err(|e| format!("{e} | call: vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([1.0, 2.0]), create_float32x4_t_from([3.0, 4.0, 5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_laneq_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_laneq_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[5, 2, 3, 4]).map_err(|e| format!("{e} | call: vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_laneq_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[3, 2]).map_err(|e| format!("{e} | call: vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_laneq_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_laneq_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[5, 2, 3, 4]).map_err(|e| format!("{e} | call: vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_laneq_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[3, 2]).map_err(|e| format!("{e} | call: vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_laneq_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_laneq_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([1, 2, 3, 4]), create_poly16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[5, 2, 3, 4]).map_err(|e| format!("{e} | call: vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([1, 2, 3, 4]), create_poly16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_laneq_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([1.0]), create_float64x2_t_from([2.0, 3.0])));
        check_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([1.0]), create_float64x2_t_from([2.0, 3.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_laneq_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([1]), create_int64x2_t_from([2, 3])));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([1]), create_int64x2_t_from([2, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_laneq_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([1]), create_uint64x2_t_from([2, 3])));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([1]), create_uint64x2_t_from([2, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_laneq_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([1]), create_poly64x2_t_from([2, 3])));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([1]), create_poly64x2_t_from([2, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopy_laneq_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopyq_lane_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcopyq_lane_f32::<0, 0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x2_t_from([5.0, 6.0])));
        check_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: vcopyq_lane_f32::<0, 0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x2_t_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopyq_lane_f32::<0, 0>(create_random_float32x4_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopyq_lane_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcopyq_lane_f64::<0, 0>(create_float64x2_t_from([1.0, 2.0]), create_float64x1_t_from([3.0])));
        check_array_equality(&result, &[3.0, 2.0]).map_err(|e| format!("{e} | call: vcopyq_lane_f64::<0, 0>(create_float64x2_t_from([1.0, 2.0]), create_float64x1_t_from([3.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopyq_lane_f64::<0, 0>(create_random_float64x2_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopyq_lane_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vcopyq_lane_s64::<0, 0>(create_int64x2_t_from([1, 2]), create_int64x1_t_from([3])));
        check_array_equality(&result, &[3, 2]).map_err(|e| format!("{e} | call: vcopyq_lane_s64::<0, 0>(create_int64x2_t_from([1, 2]), create_int64x1_t_from([3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopyq_lane_s64::<0, 0>(create_random_int64x2_t(), create_random_int64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopyq_lane_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcopyq_lane_u64::<0, 0>(create_uint64x2_t_from([1, 2]), create_uint64x1_t_from([3])));
        check_array_equality(&result, &[3, 2]).map_err(|e| format!("{e} | call: vcopyq_lane_u64::<0, 0>(create_uint64x2_t_from([1, 2]), create_uint64x1_t_from([3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopyq_lane_u64::<0, 0>(create_random_uint64x2_t(), create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopyq_lane_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vcopyq_lane_p64::<0, 0>(create_poly64x2_t_from([1, 2]), create_poly64x1_t_from([3])));
        check_array_equality(&result, &[3, 2]).map_err(|e| format!("{e} | call: vcopyq_lane_p64::<0, 0>(create_poly64x2_t_from([1, 2]), create_poly64x1_t_from([3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopyq_lane_p64::<0, 0>(create_random_poly64x2_t(), create_random_poly64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopyq_lane_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vcopyq_lane_s8::<0, 0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[17, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vcopyq_lane_s8::<0, 0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopyq_lane_s8::<0, 0>(create_random_int8x16_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopyq_lane_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vcopyq_lane_s16::<0, 0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vcopyq_lane_s16::<0, 0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopyq_lane_s16::<0, 0>(create_random_int16x8_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopyq_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcopyq_lane_s32::<0, 0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[5, 2, 3, 4]).map_err(|e| format!("{e} | call: vcopyq_lane_s32::<0, 0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopyq_lane_s32::<0, 0>(create_random_int32x4_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopyq_lane_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vcopyq_lane_u8::<0, 0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[17, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vcopyq_lane_u8::<0, 0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopyq_lane_u8::<0, 0>(create_random_uint8x16_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopyq_lane_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vcopyq_lane_u16::<0, 0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vcopyq_lane_u16::<0, 0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopyq_lane_u16::<0, 0>(create_random_uint16x8_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopyq_lane_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcopyq_lane_u32::<0, 0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[5, 2, 3, 4]).map_err(|e| format!("{e} | call: vcopyq_lane_u32::<0, 0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopyq_lane_u32::<0, 0>(create_random_uint32x4_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopyq_lane_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vcopyq_lane_p8::<0, 0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_poly8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[17, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vcopyq_lane_p8::<0, 0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_poly8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopyq_lane_p8::<0, 0>(create_random_poly8x16_t(), create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopyq_lane_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vcopyq_lane_p16::<0, 0>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vcopyq_lane_p16::<0, 0>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopyq_lane_p16::<0, 0>(create_random_poly16x8_t(), create_random_poly16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcopyq_laneq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcopyq_laneq_f32::<0, 0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: vcopyq_laneq_f32::<0, 0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcopyq_laneq_f32::<0, 0>(create_random_float32x4_t(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}
