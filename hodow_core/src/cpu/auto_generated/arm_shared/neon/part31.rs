#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_arm_shared_neon_vrshrn_n_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vrshrn_n_u64::<1>(create_uint64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vrshrn_n_u64::<1>(create_uint64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrshrn_n_u64::<1>(create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsqrte_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vrsqrte_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0.9980469, 0.7050781]).map_err(|e| format!("{e} | call: vrsqrte_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsqrte_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsqrteq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vrsqrteq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.9980469, 0.7050781, 0.5761719, 0.49902344]).map_err(|e| format!("{e} | call: vrsqrteq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsqrteq_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsqrte_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vrsqrte_u32(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| format!("{e} | call: vrsqrte_u32(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsqrte_u32(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsqrteq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vrsqrteq_u32(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| format!("{e} | call: vrsqrteq_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsqrteq_u32(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsqrts_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vrsqrts_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[0.0, -2.5]).map_err(|e| format!("{e} | call: vrsqrts_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsqrts_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsqrtsq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vrsqrtsq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[-1.0, -4.5, -9.0, -14.5]).map_err(|e| format!("{e} | call: vrsqrtsq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsqrtsq_f32(create_random_float32x4_t(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsra_n_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vrsra_n_s8::<1>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[6, 7, 9, 10, 12, 13, 15, 16]).map_err(|e| format!("{e} | call: vrsra_n_s8::<1>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsra_n_s8::<1>(create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsraq_n_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vrsraq_n_s8::<1>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[10, 11, 13, 14, 16, 17, 19, 20, 22, 23, 25, 26, 28, 29, 31, 32]).map_err(|e| format!("{e} | call: vrsraq_n_s8::<1>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsraq_n_s8::<1>(create_random_int8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsra_n_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vrsra_n_s16::<1>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 5, 7, 8]).map_err(|e| format!("{e} | call: vrsra_n_s16::<1>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsra_n_s16::<1>(create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsraq_n_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vrsraq_n_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[6, 7, 9, 10, 12, 13, 15, 16]).map_err(|e| format!("{e} | call: vrsraq_n_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsraq_n_s16::<1>(create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsra_n_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vrsra_n_s32::<1>(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 4]).map_err(|e| format!("{e} | call: vrsra_n_s32::<1>(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsra_n_s32::<1>(create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsraq_n_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vrsraq_n_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 5, 7, 8]).map_err(|e| format!("{e} | call: vrsraq_n_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsraq_n_s32::<1>(create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsra_n_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vrsra_n_s64::<1>(create_int64x1_t_from([1]), create_int64x1_t_from([2])));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: vrsra_n_s64::<1>(create_int64x1_t_from([1]), create_int64x1_t_from([2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsra_n_s64::<1>(create_random_int64x1_t(), create_random_int64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsraq_n_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vrsraq_n_s64::<1>(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 4]).map_err(|e| format!("{e} | call: vrsraq_n_s64::<1>(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsraq_n_s64::<1>(create_random_int64x2_t(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsra_n_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vrsra_n_u8::<1>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[6, 7, 9, 10, 12, 13, 15, 16]).map_err(|e| format!("{e} | call: vrsra_n_u8::<1>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsra_n_u8::<1>(create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsraq_n_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vrsraq_n_u8::<1>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[10, 11, 13, 14, 16, 17, 19, 20, 22, 23, 25, 26, 28, 29, 31, 32]).map_err(|e| format!("{e} | call: vrsraq_n_u8::<1>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsraq_n_u8::<1>(create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsra_n_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vrsra_n_u16::<1>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 5, 7, 8]).map_err(|e| format!("{e} | call: vrsra_n_u16::<1>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsra_n_u16::<1>(create_random_uint16x4_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsraq_n_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vrsraq_n_u16::<1>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[6, 7, 9, 10, 12, 13, 15, 16]).map_err(|e| format!("{e} | call: vrsraq_n_u16::<1>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsraq_n_u16::<1>(create_random_uint16x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsra_n_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vrsra_n_u32::<1>(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 4]).map_err(|e| format!("{e} | call: vrsra_n_u32::<1>(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsra_n_u32::<1>(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsraq_n_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vrsraq_n_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 5, 7, 8]).map_err(|e| format!("{e} | call: vrsraq_n_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsraq_n_u32::<1>(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsra_n_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vrsra_n_u64::<1>(create_uint64x1_t_from([1]), create_uint64x1_t_from([2])));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: vrsra_n_u64::<1>(create_uint64x1_t_from([1]), create_uint64x1_t_from([2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsra_n_u64::<1>(create_random_uint64x1_t(), create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsraq_n_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vrsraq_n_u64::<1>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 4]).map_err(|e| format!("{e} | call: vrsraq_n_u64::<1>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsraq_n_u64::<1>(create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsubhn_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vrsubhn_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0i8; 8]).map_err(|e| format!("{e} | call: vrsubhn_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsubhn_s16(create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsubhn_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vrsubhn_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[0i16; 4]).map_err(|e| format!("{e} | call: vrsubhn_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsubhn_s32(create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsubhn_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vrsubhn_s64(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[0i32; 2]).map_err(|e| format!("{e} | call: vrsubhn_s64(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsubhn_s64(create_random_int64x2_t(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsubhn_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vrsubhn_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0u8; 8]).map_err(|e| format!("{e} | call: vrsubhn_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsubhn_u16(create_random_uint16x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsubhn_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vrsubhn_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[0u16; 4]).map_err(|e| format!("{e} | call: vrsubhn_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsubhn_u32(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vrsubhn_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vrsubhn_u64(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[0u32; 2]).map_err(|e| format!("{e} | call: vrsubhn_u64(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsubhn_u64(create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vset_lane_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vset_lane_f32::<0>(1.0f32, create_float32x2_t_from([2.0, 3.0])));
        check_array_equality(&result, &[1.0, 3.0]).map_err(|e| format!("{e} | call: vset_lane_f32::<0>(1.0f32, create_float32x2_t_from([2.0, 3.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vset_lane_f32::<0>(rand::random::<f32>(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsetq_lane_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vsetq_lane_f32::<0>(1.0f32, create_float32x4_t_from([2.0, 3.0, 4.0, 5.0])));
        check_array_equality(&result, &[1.0, 3.0, 4.0, 5.0]).map_err(|e| format!("{e} | call: vsetq_lane_f32::<0>(1.0f32, create_float32x4_t_from([2.0, 3.0, 4.0, 5.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsetq_lane_f32::<0>(rand::random::<f32>(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vset_lane_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vset_lane_s8::<0>(1i8, create_int8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9])));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9]).map_err(|e| format!("{e} | call: vset_lane_s8::<0>(1i8, create_int8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vset_lane_s8::<0>(rand::random::<i8>(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsetq_lane_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vsetq_lane_s8::<0>(1i8, create_int8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17])));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]).map_err(|e| format!("{e} | call: vsetq_lane_s8::<0>(1i8, create_int8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsetq_lane_s8::<0>(rand::random::<i8>(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vset_lane_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vset_lane_s16::<0>(1i16, create_int16x4_t_from([2, 3, 4, 5])));
        check_array_equality(&result, &[1, 3, 4, 5]).map_err(|e| format!("{e} | call: vset_lane_s16::<0>(1i16, create_int16x4_t_from([2, 3, 4, 5]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vset_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsetq_lane_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vsetq_lane_s16::<0>(1i16, create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9])));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9]).map_err(|e| format!("{e} | call: vsetq_lane_s16::<0>(1i16, create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsetq_lane_s16::<0>(rand::random::<i16>(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vset_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vset_lane_s32::<0>(1i32, create_int32x2_t_from([2, 3])));
        check_array_equality(&result, &[1, 3]).map_err(|e| format!("{e} | call: vset_lane_s32::<0>(1i32, create_int32x2_t_from([2, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vset_lane_s32::<0>(rand::random::<i32>(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsetq_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsetq_lane_s32::<0>(1i32, create_int32x4_t_from([2, 3, 4, 5])));
        check_array_equality(&result, &[1, 3, 4, 5]).map_err(|e| format!("{e} | call: vsetq_lane_s32::<0>(1i32, create_int32x4_t_from([2, 3, 4, 5]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsetq_lane_s32::<0>(rand::random::<i32>(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsetq_lane_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vsetq_lane_s64::<0>(1i64, create_int64x2_t_from([2, 3])));
        check_array_equality(&result, &[1, 3]).map_err(|e| format!("{e} | call: vsetq_lane_s64::<0>(1i64, create_int64x2_t_from([2, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsetq_lane_s64::<0>(rand::random::<i64>(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vset_lane_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vset_lane_u8::<0>(1u8, create_uint8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9])));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9]).map_err(|e| format!("{e} | call: vset_lane_u8::<0>(1u8, create_uint8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vset_lane_u8::<0>(rand::random::<u8>(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsetq_lane_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vsetq_lane_u8::<0>(1u8, create_uint8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17])));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]).map_err(|e| format!("{e} | call: vsetq_lane_u8::<0>(1u8, create_uint8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsetq_lane_u8::<0>(rand::random::<u8>(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vset_lane_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vset_lane_u16::<0>(1u16, create_uint16x4_t_from([2, 3, 4, 5])));
        check_array_equality(&result, &[1, 3, 4, 5]).map_err(|e| format!("{e} | call: vset_lane_u16::<0>(1u16, create_uint16x4_t_from([2, 3, 4, 5]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vset_lane_u16::<0>(rand::random::<u16>(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsetq_lane_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vsetq_lane_u16::<0>(1u16, create_uint16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9])));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9]).map_err(|e| format!("{e} | call: vsetq_lane_u16::<0>(1u16, create_uint16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsetq_lane_u16::<0>(rand::random::<u16>(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vset_lane_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vset_lane_u32::<0>(1u32, create_uint32x2_t_from([2, 3])));
        check_array_equality(&result, &[1, 3]).map_err(|e| format!("{e} | call: vset_lane_u32::<0>(1u32, create_uint32x2_t_from([2, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vset_lane_u32::<0>(rand::random::<u32>(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsetq_lane_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsetq_lane_u32::<0>(1u32, create_uint32x4_t_from([2, 3, 4, 5])));
        check_array_equality(&result, &[1, 3, 4, 5]).map_err(|e| format!("{e} | call: vsetq_lane_u32::<0>(1u32, create_uint32x4_t_from([2, 3, 4, 5]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsetq_lane_u32::<0>(rand::random::<u32>(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsetq_lane_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsetq_lane_u64::<0>(1u64, create_uint64x2_t_from([2, 3])));
        check_array_equality(&result, &[1, 3]).map_err(|e| format!("{e} | call: vsetq_lane_u64::<0>(1u64, create_uint64x2_t_from([2, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsetq_lane_u64::<0>(rand::random::<u64>(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vset_lane_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vset_lane_p8::<0>(1u8, create_poly8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9])));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9]).map_err(|e| format!("{e} | call: vset_lane_p8::<0>(1u8, create_poly8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vset_lane_p8::<0>(rand::random::<u8>(), create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsetq_lane_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsetq_lane_p8::<0>(1u8, create_poly8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17])));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]).map_err(|e| format!("{e} | call: vsetq_lane_p8::<0>(1u8, create_poly8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsetq_lane_p8::<0>(rand::random::<u8>(), create_random_poly8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vset_lane_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vset_lane_p16::<0>(1u16, create_poly16x4_t_from([2, 3, 4, 5])));
        check_array_equality(&result, &[1, 3, 4, 5]).map_err(|e| format!("{e} | call: vset_lane_p16::<0>(1u16, create_poly16x4_t_from([2, 3, 4, 5]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vset_lane_p16::<0>(rand::random::<u16>(), create_random_poly16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vsetq_lane_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsetq_lane_p16::<0>(1u16, create_poly16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9])));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9]).map_err(|e| format!("{e} | call: vsetq_lane_p16::<0>(1u16, create_poly16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsetq_lane_p16::<0>(rand::random::<u16>(), create_random_poly16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vset_lane_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vset_lane_p64::<0>(1u64, create_poly64x1_t_from([2])));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vset_lane_p64::<0>(1u64, create_poly64x1_t_from([2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vset_lane_p64::<0>(rand::random::<u64>(), create_random_poly64x1_t());
            }
        }
    }
    Ok(())
}
