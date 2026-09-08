use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_neon_vsrid_n_s64() -> Result<(), String> {
    unsafe {
        let result = vsrid_n_s64::<1>(1i64, 2i64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vsrid_n_s64::<1>(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsrid_n_s64::<1>(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vsrid_n_u64() -> Result<(), String> {
    unsafe {
        let result = vsrid_n_u64::<1>(1u64, 2u64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vsrid_n_u64::<1>(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsrid_n_u64::<1>(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1_f32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x2_t_from([2.0, 3.0]);
        vst1_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1q_f32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x4_t_from([2.0, 3.0, 4.0, 5.0]);
        vst1q_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1_f64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create_float64x1_t_from([2.0]);
        vst1_f64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1q_f64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create_float64x2_t_from([2.0, 3.0]);
        vst1q_f64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1_s8() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1q_s8() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        vst1q_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1_s16() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x4_t_from([2, 3, 4, 5]);
        vst1_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1q_s16() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1q_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1_s32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x2_t_from([2, 3]);
        vst1_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1q_s32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x4_t_from([2, 3, 4, 5]);
        vst1q_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1_s64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x1_t_from([2]);
        vst1_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1q_s64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x2_t_from([2, 3]);
        vst1q_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1q_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        vst1q_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1_u16() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x4_t_from([2, 3, 4, 5]);
        vst1_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1q_u16() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1q_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1_u32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x2_t_from([2, 3]);
        vst1_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1q_u32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x4_t_from([2, 3, 4, 5]);
        vst1q_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1_u64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x1_t_from([2]);
        vst1_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1q_u64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x2_t_from([2, 3]);
        vst1q_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1_p8() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1q_p8() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        vst1q_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1_p16() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x4_t_from([2, 3, 4, 5]);
        vst1_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1q_p16() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1q_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1_p64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x1_t_from([2]);
        vst1_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1q_p64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x2_t_from([2, 3]);
        vst1q_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1_lane_f64() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f64; 8]);
        let b = create_float64x1_t_from([2.0]);
        vst1_lane_f64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vst1q_lane_f64() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f64; 8]);
        let b = create_float64x2_t_from([2.0, 3.0]);
        vst1q_lane_f64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vstl1_lane_f64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let val = create_float64x1_t_from([2.0]);
        vstl1_lane_f64::<0>(ptr_ptr.0.as_mut_ptr(), val);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vstl1q_lane_f64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let val = create_float64x2_t_from([2.0, 3.0]);
        vstl1q_lane_f64::<0>(ptr_ptr.0.as_mut_ptr(), val);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vstl1_lane_u64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let val = create_uint64x1_t_from([2]);
        vstl1_lane_u64::<0>(ptr_ptr.0.as_mut_ptr(), val);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vstl1q_lane_u64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let val = create_uint64x2_t_from([2, 3]);
        vstl1q_lane_u64::<0>(ptr_ptr.0.as_mut_ptr(), val);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vstl1_lane_p64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let val = create_poly64x1_t_from([2]);
        vstl1_lane_p64::<0>(ptr_ptr.0.as_mut_ptr(), val);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vstl1q_lane_p64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let val = create_poly64x2_t_from([2, 3]);
        vstl1q_lane_p64::<0>(ptr_ptr.0.as_mut_ptr(), val);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vstl1_lane_s64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let val = create_int64x1_t_from([2]);
        vstl1_lane_s64::<0>(ptr_ptr.0.as_mut_ptr(), val);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vstl1q_lane_s64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let val = create_int64x2_t_from([2, 3]);
        vstl1q_lane_s64::<0>(ptr_ptr.0.as_mut_ptr(), val);
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vsub_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vsub_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0])));
        check_array_equality(&result, &[-1.0]).map_err(|e| format!("{e} | call: vsub_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsub_f64(create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vsubq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vsubq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[-2.0, -2.0]).map_err(|e| format!("{e} | call: vsubq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubq_f64(create_random_float64x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vsubd_s64() -> Result<(), String> {
    unsafe {
        let result = vsubd_s64(1i64, 2i64);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vsubd_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubd_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vsubd_u64() -> Result<(), String> {
    unsafe {
        let result = vsubd_u64(1u64, 2u64);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vsubd_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubd_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vsubl_high_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vsubl_high_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-16, -16, -16, -16, -16, -16, -16, -16]).map_err(|e| format!("{e} | call: vsubl_high_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubl_high_s8(create_random_int8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vsubl_high_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsubl_high_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-8, -8, -8, -8]).map_err(|e| format!("{e} | call: vsubl_high_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubl_high_s16(create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vsubl_high_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vsubl_high_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-4, -4]).map_err(|e| format!("{e} | call: vsubl_high_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubl_high_s32(create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vsubl_high_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vsubl_high_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[65520, 65520, 65520, 65520, 65520, 65520, 65520, 65520]).map_err(|e| format!("{e} | call: vsubl_high_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubl_high_u8(create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vsubl_high_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsubl_high_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967288, 4294967288, 4294967288, 4294967288]).map_err(|e| format!("{e} | call: vsubl_high_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubl_high_u16(create_random_uint16x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vsubl_high_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsubl_high_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551612, 18446744073709551612]).map_err(|e| format!("{e} | call: vsubl_high_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubl_high_u32(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vsubw_high_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vsubw_high_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-16, -16, -16, -16, -16, -16, -16, -16]).map_err(|e| format!("{e} | call: vsubw_high_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubw_high_s8(create_random_int16x8_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vsubw_high_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsubw_high_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[-8, -8, -8, -8]).map_err(|e| format!("{e} | call: vsubw_high_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubw_high_s16(create_random_int32x4_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}
