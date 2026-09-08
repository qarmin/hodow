#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_arm_shared_neon_vorrq_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vorrq_u64(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 6]).map_err(|e| format!("{e} | call: vorrq_u64(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vorrq_u64(create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadal_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vpadal_s8(create_int16x4_t_from([1, 2, 3, 4]), create_int8x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[12, 17, 22, 27]).map_err(|e| format!("{e} | call: vpadal_s8(create_int16x4_t_from([1, 2, 3, 4]), create_int8x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadal_s8(create_random_int16x4_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadalq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vpadalq_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[20, 25, 30, 35, 40, 45, 50, 55]).map_err(|e| format!("{e} | call: vpadalq_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadalq_s8(create_random_int16x8_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadal_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vpadal_s16(create_int32x2_t_from([1, 2]), create_int16x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[8, 13]).map_err(|e| format!("{e} | call: vpadal_s16(create_int32x2_t_from([1, 2]), create_int16x4_t_from([3, 4, 5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadal_s16(create_random_int32x2_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadalq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vpadalq_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[12, 17, 22, 27]).map_err(|e| format!("{e} | call: vpadalq_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadalq_s16(create_random_int32x4_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadal_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vpadal_s32(create_int64x1_t_from([1]), create_int32x2_t_from([2, 3])));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: vpadal_s32(create_int64x1_t_from([1]), create_int32x2_t_from([2, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadal_s32(create_random_int64x1_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadalq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vpadalq_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[8, 13]).map_err(|e| format!("{e} | call: vpadalq_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadalq_s32(create_random_int64x2_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadal_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vpadal_u8(create_uint16x4_t_from([1, 2, 3, 4]), create_uint8x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[12, 17, 22, 27]).map_err(|e| format!("{e} | call: vpadal_u8(create_uint16x4_t_from([1, 2, 3, 4]), create_uint8x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadal_u8(create_random_uint16x4_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadalq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vpadalq_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[20, 25, 30, 35, 40, 45, 50, 55]).map_err(|e| format!("{e} | call: vpadalq_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadalq_u8(create_random_uint16x8_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadal_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vpadal_u16(create_uint32x2_t_from([1, 2]), create_uint16x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[8, 13]).map_err(|e| format!("{e} | call: vpadal_u16(create_uint32x2_t_from([1, 2]), create_uint16x4_t_from([3, 4, 5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadal_u16(create_random_uint32x2_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadalq_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vpadalq_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[12, 17, 22, 27]).map_err(|e| format!("{e} | call: vpadalq_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadalq_u16(create_random_uint32x4_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadal_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vpadal_u32(create_uint64x1_t_from([1]), create_uint32x2_t_from([2, 3])));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: vpadal_u32(create_uint64x1_t_from([1]), create_uint32x2_t_from([2, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadal_u32(create_random_uint64x1_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadalq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vpadalq_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[8, 13]).map_err(|e| format!("{e} | call: vpadalq_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadalq_u32(create_random_uint64x2_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadd_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vpadd_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[3.0, 7.0]).map_err(|e| format!("{e} | call: vpadd_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadd_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadd_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vpadd_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[3, 7, 11, 15, 19, 23, 27, 31]).map_err(|e| format!("{e} | call: vpadd_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadd_s8(create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadd_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vpadd_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[3, 7, 11, 15]).map_err(|e| format!("{e} | call: vpadd_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadd_s16(create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadd_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vpadd_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 7]).map_err(|e| format!("{e} | call: vpadd_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadd_s32(create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadd_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vpadd_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[3, 7, 11, 15, 19, 23, 27, 31]).map_err(|e| format!("{e} | call: vpadd_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadd_u8(create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadd_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vpadd_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[3, 7, 11, 15]).map_err(|e| format!("{e} | call: vpadd_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadd_u16(create_random_uint16x4_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpadd_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vpadd_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 7]).map_err(|e| format!("{e} | call: vpadd_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpadd_u32(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpaddl_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vpaddl_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[3, 7, 11, 15]).map_err(|e| format!("{e} | call: vpaddl_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpaddl_s8(create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpaddlq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vpaddlq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[3, 7, 11, 15, 19, 23, 27, 31]).map_err(|e| format!("{e} | call: vpaddlq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpaddlq_s8(create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpaddl_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vpaddl_s16(create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[3, 7]).map_err(|e| format!("{e} | call: vpaddl_s16(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpaddl_s16(create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpaddlq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vpaddlq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[3, 7, 11, 15]).map_err(|e| format!("{e} | call: vpaddlq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpaddlq_s16(create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpaddl_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vpaddl_s32(create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: vpaddl_s32(create_int32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpaddl_s32(create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpaddlq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vpaddlq_s32(create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[3, 7]).map_err(|e| format!("{e} | call: vpaddlq_s32(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpaddlq_s32(create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpaddl_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vpaddl_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[3, 7, 11, 15]).map_err(|e| format!("{e} | call: vpaddl_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpaddl_u8(create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpaddlq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vpaddlq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[3, 7, 11, 15, 19, 23, 27, 31]).map_err(|e| format!("{e} | call: vpaddlq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpaddlq_u8(create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpaddl_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vpaddl_u16(create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[3, 7]).map_err(|e| format!("{e} | call: vpaddl_u16(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpaddl_u16(create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpaddlq_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vpaddlq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[3, 7, 11, 15]).map_err(|e| format!("{e} | call: vpaddlq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpaddlq_u16(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpaddl_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vpaddl_u32(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: vpaddl_u32(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpaddl_u32(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpaddlq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vpaddlq_u32(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[3, 7]).map_err(|e| format!("{e} | call: vpaddlq_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpaddlq_u32(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpmax_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vpmax_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[2.0, 4.0]).map_err(|e| format!("{e} | call: vpmax_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpmax_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpmax_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vpmax_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2, 4, 6, 8, 10, 12, 14, 16]).map_err(|e| format!("{e} | call: vpmax_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpmax_s8(create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpmax_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vpmax_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[2, 4, 6, 8]).map_err(|e| format!("{e} | call: vpmax_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpmax_s16(create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpmax_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vpmax_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[2, 4]).map_err(|e| format!("{e} | call: vpmax_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpmax_s32(create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpmax_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vpmax_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2, 4, 6, 8, 10, 12, 14, 16]).map_err(|e| format!("{e} | call: vpmax_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpmax_u8(create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpmax_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vpmax_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[2, 4, 6, 8]).map_err(|e| format!("{e} | call: vpmax_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpmax_u16(create_random_uint16x4_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpmax_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vpmax_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[2, 4]).map_err(|e| format!("{e} | call: vpmax_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpmax_u32(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpmin_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vpmin_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[1.0, 3.0]).map_err(|e| format!("{e} | call: vpmin_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpmin_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpmin_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vpmin_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 3, 5, 7, 9, 11, 13, 15]).map_err(|e| format!("{e} | call: vpmin_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpmin_s8(create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpmin_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vpmin_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 3, 5, 7]).map_err(|e| format!("{e} | call: vpmin_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpmin_s16(create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpmin_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vpmin_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 3]).map_err(|e| format!("{e} | call: vpmin_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpmin_s32(create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpmin_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vpmin_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 3, 5, 7, 9, 11, 13, 15]).map_err(|e| format!("{e} | call: vpmin_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpmin_u8(create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpmin_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vpmin_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 3, 5, 7]).map_err(|e| format!("{e} | call: vpmin_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpmin_u16(create_random_uint16x4_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vpmin_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vpmin_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 3]).map_err(|e| format!("{e} | call: vpmin_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vpmin_u32(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vqabs_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vqabs_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vqabs_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqabs_s8(create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vqabsq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vqabsq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vqabsq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqabsq_s8(create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vqabs_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vqabs_s16(create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vqabs_s16(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqabs_s16(create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vqabsq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqabsq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vqabsq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqabsq_s16(create_random_int16x8_t());
            }
        }
    }
    Ok(())
}
