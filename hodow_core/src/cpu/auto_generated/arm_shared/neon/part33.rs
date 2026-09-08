#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vsri_n_u32::<1>(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vsri_n_u32::<1>(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u32::<1>(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsriq_n_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[2, 3, 3, 4]).map_err(|e| format!("{e} | call: vsriq_n_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u32::<1>(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vsri_n_u64::<1>(create_uint64x1_t_from([1]), create_uint64x1_t_from([2])));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vsri_n_u64::<1>(create_uint64x1_t_from([1]), create_uint64x1_t_from([2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u64::<1>(create_random_uint64x1_t(), create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsriq_n_u64::<1>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vsriq_n_u64::<1>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u64::<1>(create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vsri_n_p8::<1>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4, 5, 5, 6, 6, 7, 7, 8]).map_err(|e| format!("{e} | call: vsri_n_p8::<1>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p8::<1>(create_random_poly8x8_t(), create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsriq_n_p8::<1>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_poly8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 16]).map_err(|e| format!("{e} | call: vsriq_n_p8::<1>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_poly8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p8::<1>(create_random_poly8x16_t(), create_random_poly8x16_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vsri_n_p16::<1>(create_poly16x4_t_from([1, 2, 3, 4]), create_poly16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[2, 3, 3, 4]).map_err(|e| format!("{e} | call: vsri_n_p16::<1>(create_poly16x4_t_from([1, 2, 3, 4]), create_poly16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p16::<1>(create_random_poly16x4_t(), create_random_poly16x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsriq_n_p16::<1>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4, 5, 5, 6, 6, 7, 7, 8]).map_err(|e| format!("{e} | call: vsriq_n_p16::<1>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p16::<1>(create_random_poly16x8_t(), create_random_poly16x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_f32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x2_t_from([2.0, 3.0]);
        vst1_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_f32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x4_t_from([2.0, 3.0, 4.0, 5.0]);
        vst1q_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s8() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s8() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        vst1q_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s16() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x4_t_from([2, 3, 4, 5]);
        vst1_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s16() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1q_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x2_t_from([2, 3]);
        vst1_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x4_t_from([2, 3, 4, 5]);
        vst1q_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x1_t_from([2]);
        vst1_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x2_t_from([2, 3]);
        vst1q_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        vst1q_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u16() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x4_t_from([2, 3, 4, 5]);
        vst1_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u16() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1q_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x2_t_from([2, 3]);
        vst1_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x4_t_from([2, 3, 4, 5]);
        vst1q_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x1_t_from([2]);
        vst1_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x2_t_from([2, 3]);
        vst1q_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p8() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p8() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        vst1q_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p16() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x4_t_from([2, 3, 4, 5]);
        vst1_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

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
