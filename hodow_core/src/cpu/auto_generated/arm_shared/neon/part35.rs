#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p16() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1q_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x1_t_from([2]);
        vst1_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x2_t_from([2, 3]);
        vst1q_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_f32() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f32; 16]);
        let b = create_float32x2_t_from([2.0, 3.0]);
        vst1_lane_f32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_f32() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f32; 16]);
        let b = create_float32x4_t_from([2.0, 3.0, 4.0, 5.0]);
        vst1q_lane_f32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s8() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i8; 64]);
        let b = create_int8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1_lane_s8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s8() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i8; 64]);
        let b = create_int8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        vst1q_lane_s8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s16() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i16; 32]);
        let b = create_int16x4_t_from([2, 3, 4, 5]);
        vst1_lane_s16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s16() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i16; 32]);
        let b = create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1q_lane_s16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s32() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i32; 16]);
        let b = create_int32x2_t_from([2, 3]);
        vst1_lane_s32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s32() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i32; 16]);
        let b = create_int32x4_t_from([2, 3, 4, 5]);
        vst1q_lane_s32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s64() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i64; 8]);
        let b = create_int64x2_t_from([2, 3]);
        vst1q_lane_s64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_uint8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1_lane_u8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_uint8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        vst1q_lane_u8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u16() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 32]);
        let b = create_uint16x4_t_from([2, 3, 4, 5]);
        vst1_lane_u16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u16() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 32]);
        let b = create_uint16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1q_lane_u16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u32() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u32; 16]);
        let b = create_uint32x2_t_from([2, 3]);
        vst1_lane_u32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u32() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u32; 16]);
        let b = create_uint32x4_t_from([2, 3, 4, 5]);
        vst1q_lane_u32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u64() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u64; 8]);
        let b = create_uint64x2_t_from([2, 3]);
        vst1q_lane_u64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_p8() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_poly8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1_lane_p8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_p8() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_poly8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        vst1q_lane_p8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_p16() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 64]);
        let b = create_poly16x4_t_from([2, 3, 4, 5]);
        vst1_lane_p16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_p16() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 64]);
        let b = create_poly16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1q_lane_p16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_p64() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u64; 64]);
        let b = create_poly64x1_t_from([2]);
        vst1_lane_p64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s64() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i64; 8]);
        let b = create_int64x1_t_from([2]);
        vst1_lane_s64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u64() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u64; 8]);
        let b = create_uint64x1_t_from([2]);
        vst1_lane_u64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_p64() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u64; 64]);
        let b = create_poly64x2_t_from([2, 3]);
        vst1q_lane_p64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vstrq_p128() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u128; 64]);
        let b = 2u128;
        vstrq_p128(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsub_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vsub_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[-2.0, -2.0]).map_err(|e| format!("{e} | call: vsub_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsub_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsubq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vsubq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[-4.0, -4.0, -4.0, -4.0]).map_err(|e| format!("{e} | call: vsubq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubq_f32(create_random_float32x4_t(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsub_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vsub_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-4, -4, -4, -4]).map_err(|e| format!("{e} | call: vsub_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsub_s16(create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsubq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vsubq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-8, -8, -8, -8, -8, -8, -8, -8]).map_err(|e| format!("{e} | call: vsubq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubq_s16(create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsub_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vsub_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[65532, 65532, 65532, 65532]).map_err(|e| format!("{e} | call: vsub_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsub_u16(create_random_uint16x4_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsubq_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vsubq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[65528, 65528, 65528, 65528, 65528, 65528, 65528, 65528]).map_err(|e| format!("{e} | call: vsubq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubq_u16(create_random_uint16x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsub_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vsub_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[-2, -2]).map_err(|e| format!("{e} | call: vsub_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsub_s32(create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsubq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsubq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-4, -4, -4, -4]).map_err(|e| format!("{e} | call: vsubq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubq_s32(create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsub_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vsub_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[4294967294, 4294967294]).map_err(|e| format!("{e} | call: vsub_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsub_u32(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsubq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsubq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4294967292, 4294967292, 4294967292, 4294967292]).map_err(|e| format!("{e} | call: vsubq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubq_u32(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsub_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vsub_s64(create_int64x1_t_from([1]), create_int64x1_t_from([2])));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: vsub_s64(create_int64x1_t_from([1]), create_int64x1_t_from([2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsub_s64(create_random_int64x1_t(), create_random_int64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsubq_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vsubq_s64(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[-2, -2]).map_err(|e| format!("{e} | call: vsubq_s64(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubq_s64(create_random_int64x2_t(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsub_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vsub_u64(create_uint64x1_t_from([1]), create_uint64x1_t_from([2])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: vsub_u64(create_uint64x1_t_from([1]), create_uint64x1_t_from([2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsub_u64(create_random_uint64x1_t(), create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsubq_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsubq_u64(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[18446744073709551614, 18446744073709551614]).map_err(|e| format!("{e} | call: vsubq_u64(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubq_u64(create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsub_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vsub_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-8, -8, -8, -8, -8, -8, -8, -8]).map_err(|e| format!("{e} | call: vsub_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsub_s8(create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsubq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vsubq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-16, -16, -16, -16, -16, -16, -16, -16, -16, -16, -16, -16, -16, -16, -16, -16]).map_err(|e| format!("{e} | call: vsubq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubq_s8(create_random_int8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsub_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vsub_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[248, 248, 248, 248, 248, 248, 248, 248]).map_err(|e| format!("{e} | call: vsub_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsub_u8(create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsubq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vsubq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240]).map_err(|e| format!("{e} | call: vsubq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubq_u8(create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsubhn_high_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vsubhn_high_s16(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: vsubhn_high_s16(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubhn_high_s16(create_random_int8x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsubhn_high_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vsubhn_high_s32(create_int16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[1, 2, 3, 4, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: vsubhn_high_s32(create_int16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubhn_high_s32(create_random_int16x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsubhn_high_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsubhn_high_s64(create_int32x2_t_from([1, 2]), create_int64x2_t_from([3, 4]), create_int64x2_t_from([5, 6])));
        check_array_equality(&result, &[1, 2, -1, -1]).map_err(|e| format!("{e} | call: vsubhn_high_s64(create_int32x2_t_from([1, 2]), create_int64x2_t_from([3, 4]), create_int64x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubhn_high_s64(create_random_int32x2_t(), create_random_int64x2_t(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsubhn_high_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vsubhn_high_u16(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| format!("{e} | call: vsubhn_high_u16(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsubhn_high_u16(create_random_uint8x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}
