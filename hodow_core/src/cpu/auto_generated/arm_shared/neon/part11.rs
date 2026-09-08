#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_arm_shared_neon_vhaddq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vhaddq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]).map_err(|e| format!("{e} | call: vhaddq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vhaddq_u8(create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vhadd_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vhadd_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[3, 4, 5, 6]).map_err(|e| format!("{e} | call: vhadd_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vhadd_u16(create_random_uint16x4_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vhaddq_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vhaddq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[5, 6, 7, 8, 9, 10, 11, 12]).map_err(|e| format!("{e} | call: vhaddq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vhaddq_u16(create_random_uint16x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vhadd_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vhadd_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[2, 3]).map_err(|e| format!("{e} | call: vhadd_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vhadd_u32(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vhaddq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vhaddq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[3, 4, 5, 6]).map_err(|e| format!("{e} | call: vhaddq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vhaddq_u32(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vhsub_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vhsub_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-2, -2, -2, -2]).map_err(|e| format!("{e} | call: vhsub_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vhsub_s16(create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vhsubq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vhsubq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-4, -4, -4, -4, -4, -4, -4, -4]).map_err(|e| format!("{e} | call: vhsubq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vhsubq_s16(create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vhsub_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vhsub_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[-1, -1]).map_err(|e| format!("{e} | call: vhsub_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vhsub_s32(create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vhsubq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vhsubq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-2, -2, -2, -2]).map_err(|e| format!("{e} | call: vhsubq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vhsubq_s32(create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vhsub_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vhsub_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-4, -4, -4, -4, -4, -4, -4, -4]).map_err(|e| format!("{e} | call: vhsub_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vhsub_s8(create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vhsubq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vhsubq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-8, -8, -8, -8, -8, -8, -8, -8, -8, -8, -8, -8, -8, -8, -8, -8]).map_err(|e| format!("{e} | call: vhsubq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vhsubq_s8(create_random_int8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vhsub_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vhsub_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[252, 252, 252, 252, 252, 252, 252, 252]).map_err(|e| format!("{e} | call: vhsub_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vhsub_u8(create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vhsubq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vhsubq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[248, 248, 248, 248, 248, 248, 248, 248, 248, 248, 248, 248, 248, 248, 248, 248]).map_err(|e| format!("{e} | call: vhsubq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vhsubq_u8(create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vhsub_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vhsub_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[65534, 65534, 65534, 65534]).map_err(|e| format!("{e} | call: vhsub_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vhsub_u16(create_random_uint16x4_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vhsubq_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vhsubq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[65532, 65532, 65532, 65532, 65532, 65532, 65532, 65532]).map_err(|e| format!("{e} | call: vhsubq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vhsubq_u16(create_random_uint16x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vhsub_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vhsub_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| format!("{e} | call: vhsub_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vhsub_u32(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vhsubq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vhsubq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4294967294, 4294967294, 4294967294, 4294967294]).map_err(|e| format!("{e} | call: vhsubq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vhsubq_u32(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_dup_f32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack_float32x2_t_to_f32_array(vld1_dup_f32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1.0, 1.0]).map_err(|e| format!("{e} | call: vld1_dup_f32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_dup_p16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let result = unpack_poly16x4_t_to_u16_array(vld1_dup_p16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_dup_p16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_dup_p8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_poly8x8_t_to_u8_array(vld1_dup_p8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_dup_p8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_dup_s16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack_int16x4_t_to_i16_array(vld1_dup_s16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_dup_s16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_dup_s32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack_int32x2_t_to_i32_array(vld1_dup_s32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1_dup_s32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_dup_s8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack_int8x8_t_to_i8_array(vld1_dup_s8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_dup_s8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_dup_u16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let result = unpack_uint16x4_t_to_u16_array(vld1_dup_u16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_dup_u16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_dup_u32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let result = unpack_uint32x2_t_to_u32_array(vld1_dup_u32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1_dup_u32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_dup_u8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_uint8x8_t_to_u8_array(vld1_dup_u8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_dup_u8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_dup_f32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack_float32x4_t_to_f32_array(vld1q_dup_f32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: vld1q_dup_f32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_dup_p16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let result = unpack_poly16x8_t_to_u16_array(vld1q_dup_p16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_dup_p16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_dup_p8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_poly8x16_t_to_u8_array(vld1q_dup_p8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_dup_p8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_dup_s16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack_int16x8_t_to_i16_array(vld1q_dup_s16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_dup_s16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_dup_s32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack_int32x4_t_to_i32_array(vld1q_dup_s32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_dup_s32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_dup_s64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack_int64x2_t_to_i64_array(vld1q_dup_s64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1q_dup_s64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_dup_s8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack_int8x16_t_to_i8_array(vld1q_dup_s8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_dup_s8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_dup_u16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let result = unpack_uint16x8_t_to_u16_array(vld1q_dup_u16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_dup_u16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_dup_u32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let result = unpack_uint32x4_t_to_u32_array(vld1q_dup_u32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_dup_u32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_dup_u64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let result = unpack_uint64x2_t_to_u64_array(vld1q_dup_u64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1q_dup_u64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_dup_u8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_uint8x16_t_to_u8_array(vld1q_dup_u8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_dup_u8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_dup_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let result = unpack_poly64x1_t_to_u64_array(vld1_dup_p64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_dup_p64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_dup_s64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack_int64x1_t_to_i64_array(vld1_dup_s64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_dup_s64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_dup_u64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let result = unpack_uint64x1_t_to_u64_array(vld1_dup_u64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_dup_u64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1_f32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack_float32x2_t_to_f32_array(vld1_f32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1.0, 1.0]).map_err(|e| format!("{e} | call: vld1_f32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1q_f32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack_float32x4_t_to_f32_array(vld1q_f32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: vld1q_f32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1_u8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_uint8x8_t_to_u8_array(vld1_u8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_u8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1q_u8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_uint8x16_t_to_u8_array(vld1q_u8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_u8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1_u16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let result = unpack_uint16x4_t_to_u16_array(vld1_u16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_u16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1q_u16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let result = unpack_uint16x8_t_to_u16_array(vld1q_u16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_u16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1_u32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let result = unpack_uint32x2_t_to_u32_array(vld1_u32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1_u32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1q_u32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let result = unpack_uint32x4_t_to_u32_array(vld1q_u32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_u32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1_u64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let result = unpack_uint64x1_t_to_u64_array(vld1_u64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_u64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1q_u64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let result = unpack_uint64x2_t_to_u64_array(vld1q_u64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1q_u64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}
