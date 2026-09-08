use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_neon_vdiv_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vdiv_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[0.33333334, 0.5]).map_err(|e| format!("{e} | call: vdiv_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdiv_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdivq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vdivq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.2, 0.33333334, 0.42857143, 0.5]).map_err(|e| format!("{e} | call: vdivq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdivq_f32(create_random_float32x4_t(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdiv_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vdiv_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0])));
        check_array_equality(&result, &[0.5]).map_err(|e| format!("{e} | call: vdiv_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdiv_f64(create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdivq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vdivq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[0.3333333333333333, 0.5]).map_err(|e| format!("{e} | call: vdivq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdivq_f64(create_random_float64x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdup_lane_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vdup_lane_f64::<0>(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: vdup_lane_f64::<0>(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_lane_f64::<0>(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdup_lane_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vdup_lane_p64::<0>(create_poly64x1_t_from([1])));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vdup_lane_p64::<0>(create_poly64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_lane_p64::<0>(create_random_poly64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdup_laneq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vdup_laneq_f64::<0>(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: vdup_laneq_f64::<0>(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_laneq_f64::<0>(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdup_laneq_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vdup_laneq_p64::<0>(create_poly64x2_t_from([1, 2])));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vdup_laneq_p64::<0>(create_poly64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_laneq_p64::<0>(create_random_poly64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdupb_lane_s8() -> Result<(), String> {
    unsafe {
        let result = vdupb_lane_s8::<0>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vdupb_lane_s8::<0>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupb_lane_s8::<0>(create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vduph_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = vduph_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vduph_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vduph_laneq_s16::<0>(create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdupb_lane_u8() -> Result<(), String> {
    unsafe {
        let result = vdupb_lane_u8::<0>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vdupb_lane_u8::<0>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupb_lane_u8::<0>(create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vduph_laneq_u16() -> Result<(), String> {
    unsafe {
        let result = vduph_laneq_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vduph_laneq_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vduph_laneq_u16::<0>(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdupb_lane_p8() -> Result<(), String> {
    unsafe {
        let _result = vdupb_lane_p8::<0>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupb_lane_p8::<0>(create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vduph_laneq_p16() -> Result<(), String> {
    unsafe {
        let _result = vduph_laneq_p16::<0>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vduph_laneq_p16::<0>(create_random_poly16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdupb_laneq_s8() -> Result<(), String> {
    unsafe {
        let result = vdupb_laneq_s8::<0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vdupb_laneq_s8::<0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupb_laneq_s8::<0>(create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdupb_laneq_u8() -> Result<(), String> {
    unsafe {
        let result = vdupb_laneq_u8::<0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vdupb_laneq_u8::<0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupb_laneq_u8::<0>(create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdupb_laneq_p8() -> Result<(), String> {
    unsafe {
        let _result = vdupb_laneq_p8::<0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupb_laneq_p8::<0>(create_random_poly8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdupd_lane_f64() -> Result<(), String> {
    unsafe {
        let _result = vdupd_lane_f64::<0>(create_float64x1_t_from([1.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupd_lane_f64::<0>(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdupd_lane_s64() -> Result<(), String> {
    unsafe {
        let result = vdupd_lane_s64::<0>(create_int64x1_t_from([1]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vdupd_lane_s64::<0>(create_int64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupd_lane_s64::<0>(create_random_int64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdupd_lane_u64() -> Result<(), String> {
    unsafe {
        let result = vdupd_lane_u64::<0>(create_uint64x1_t_from([1]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vdupd_lane_u64::<0>(create_uint64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupd_lane_u64::<0>(create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdupq_lane_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vdupq_lane_f64::<0>(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1.0, 1.0]).map_err(|e| format!("{e} | call: vdupq_lane_f64::<0>(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_lane_f64::<0>(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdupq_lane_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vdupq_lane_p64::<0>(create_poly64x1_t_from([1])));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vdupq_lane_p64::<0>(create_poly64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_lane_p64::<0>(create_random_poly64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdupq_laneq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vdupq_laneq_f64::<0>(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 1.0]).map_err(|e| format!("{e} | call: vdupq_laneq_f64::<0>(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_laneq_f64::<0>(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdupq_laneq_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vdupq_laneq_p64::<0>(create_poly64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vdupq_laneq_p64::<0>(create_poly64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_laneq_p64::<0>(create_random_poly64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdups_lane_f32() -> Result<(), String> {
    unsafe {
        let _result = vdups_lane_f32::<0>(create_float32x2_t_from([1.0, 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdups_lane_f32::<0>(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdupd_laneq_f64() -> Result<(), String> {
    unsafe {
        let _result = vdupd_laneq_f64::<0>(create_float64x2_t_from([1.0, 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupd_laneq_f64::<0>(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdups_lane_s32() -> Result<(), String> {
    unsafe {
        let result = vdups_lane_s32::<0>(create_int32x2_t_from([1, 2]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vdups_lane_s32::<0>(create_int32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdups_lane_s32::<0>(create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdupd_laneq_s64() -> Result<(), String> {
    unsafe {
        let result = vdupd_laneq_s64::<0>(create_int64x2_t_from([1, 2]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vdupd_laneq_s64::<0>(create_int64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupd_laneq_s64::<0>(create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdups_lane_u32() -> Result<(), String> {
    unsafe {
        let result = vdups_lane_u32::<0>(create_uint32x2_t_from([1, 2]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vdups_lane_u32::<0>(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdups_lane_u32::<0>(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdupd_laneq_u64() -> Result<(), String> {
    unsafe {
        let result = vdupd_laneq_u64::<0>(create_uint64x2_t_from([1, 2]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vdupd_laneq_u64::<0>(create_uint64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupd_laneq_u64::<0>(create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdups_laneq_f32() -> Result<(), String> {
    unsafe {
        let _result = vdups_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdups_laneq_f32::<0>(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vduph_lane_s16() -> Result<(), String> {
    unsafe {
        let result = vduph_lane_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vduph_lane_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vduph_lane_s16::<0>(create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdups_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = vdups_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vdups_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdups_laneq_s32::<0>(create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vduph_lane_u16() -> Result<(), String> {
    unsafe {
        let result = vduph_lane_u16::<0>(create_uint16x4_t_from([1, 2, 3, 4]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vduph_lane_u16::<0>(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vduph_lane_u16::<0>(create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdups_laneq_u32() -> Result<(), String> {
    unsafe {
        let result = vdups_laneq_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vdups_laneq_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdups_laneq_u32::<0>(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vduph_lane_p16() -> Result<(), String> {
    unsafe {
        let _result = vduph_lane_p16::<0>(create_poly16x4_t_from([1, 2, 3, 4]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vduph_lane_p16::<0>(create_random_poly16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_veor3q_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(veor3q_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create_int8x16_t_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 0]).map_err(|e| format!("{e} | call: veor3q_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create_int8x16_t_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = veor3q_s8(create_random_int8x16_t(), create_random_int8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_veor3q_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(veor3q_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[25, 26, 27, 28, 29, 30, 31, 0]).map_err(|e| format!("{e} | call: veor3q_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = veor3q_s16(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_veor3q_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(veor3q_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[13, 14, 15, 0]).map_err(|e| format!("{e} | call: veor3q_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = veor3q_s32(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_veor3q_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(veor3q_s64(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4]), create_int64x2_t_from([5, 6])));
        check_array_equality(&result, &[7, 0]).map_err(|e| format!("{e} | call: veor3q_s64(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4]), create_int64x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = veor3q_s64(create_random_int64x2_t(), create_random_int64x2_t(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_veor3q_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(veor3q_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create_uint8x16_t_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 0]).map_err(|e| format!("{e} | call: veor3q_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create_uint8x16_t_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = veor3q_u8(create_random_uint8x16_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_veor3q_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(veor3q_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[25, 26, 27, 28, 29, 30, 31, 0]).map_err(|e| format!("{e} | call: veor3q_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = veor3q_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_veor3q_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(veor3q_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[13, 14, 15, 0]).map_err(|e| format!("{e} | call: veor3q_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = veor3q_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_veor3q_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(veor3q_u64(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]), create_uint64x2_t_from([5, 6])));
        check_array_equality(&result, &[7, 0]).map_err(|e| format!("{e} | call: veor3q_u64(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]), create_uint64x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = veor3q_u64(create_random_uint64x2_t(), create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vextq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vextq_f64::<0>(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vextq_f64::<0>(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vextq_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vextq_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vextq_p64::<0>(create_poly64x2_t_from([1, 2]), create_poly64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vextq_p64::<0>(create_poly64x2_t_from([1, 2]), create_poly64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vextq_p64::<0>(create_random_poly64x2_t(), create_random_poly64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfma_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vfma_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]), create_float64x1_t_from([3.0])));
        check_array_equality(&result, &[7.0]).map_err(|e| format!("{e} | call: vfma_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]), create_float64x1_t_from([3.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfma_f64(create_random_float64x1_t(), create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfma_lane_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vfma_lane_f32::<0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]), create_float32x2_t_from([5.0, 6.0])));
        check_array_equality(&result, &[16.0, 22.0]).map_err(|e| format!("{e} | call: vfma_lane_f32::<0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]), create_float32x2_t_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfma_lane_f32::<0>(create_random_float32x2_t(), create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfma_laneq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vfma_laneq_f32::<0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[16.0, 22.0]).map_err(|e| format!("{e} | call: vfma_laneq_f32::<0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfma_laneq_f32::<0>(create_random_float32x2_t(), create_random_float32x2_t(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfmaq_lane_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmaq_lane_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x2_t_from([9.0, 10.0])));
        check_array_equality(&result, &[46.0, 56.0, 66.0, 76.0]).map_err(|e| format!("{e} | call: vfmaq_lane_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x2_t_from([9.0, 10.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfmaq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}
