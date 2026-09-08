#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_arm_shared_neon_crc32b() -> Result<(), String> {
    unsafe {
        let result = __crc32b(1u32, 2u8);
        check_int_equality(result as i32, -1727442502).map_err(|e| format!("{e} | call: __crc32b(1u32, 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __crc32b(rand::random::<u32>(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_crc32cb() -> Result<(), String> {
    unsafe {
        let result = __crc32cb(1u32, 2u8);
        check_int_equality(result as i32, 324072436).map_err(|e| format!("{e} | call: __crc32cb(1u32, 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __crc32cb(rand::random::<u32>(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_crc32cd() -> Result<(), String> {
    unsafe {
        let result = __crc32cd(1u32, 2u64);
        check_int_equality(result as i32, -616265879).map_err(|e| format!("{e} | call: __crc32cd(1u32, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __crc32cd(rand::random::<u32>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_crc32ch() -> Result<(), String> {
    unsafe {
        let result = __crc32ch(1u32, 2u16);
        check_int_equality(result as i32, 887597209).map_err(|e| format!("{e} | call: __crc32ch(1u32, 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __crc32ch(rand::random::<u32>(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_crc32cw() -> Result<(), String> {
    unsafe {
        let result = __crc32cw(1u32, 2u32);
        check_int_equality(result as i32, 1646430521).map_err(|e| format!("{e} | call: __crc32cw(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __crc32cw(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_crc32d() -> Result<(), String> {
    unsafe {
        let result = __crc32d(1u32, 2u64);
        check_int_equality(result as i32, -1903228957).map_err(|e| format!("{e} | call: __crc32d(1u32, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __crc32d(rand::random::<u32>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_crc32h() -> Result<(), String> {
    unsafe {
        let result = __crc32h(1u32, 2u16);
        check_int_equality(result as i32, 724390851).map_err(|e| format!("{e} | call: __crc32h(1u32, 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __crc32h(rand::random::<u32>(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_crc32w() -> Result<(), String> {
    unsafe {
        let result = __crc32w(1u32, 2u32);
        check_int_equality(result as i32, 313896942).map_err(|e| format!("{e} | call: __crc32w(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __crc32w(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vaba_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vaba_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[5, 6, 7, 8]).map_err(|e| format!("{e} | call: vaba_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaba_s16(create_random_int16x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vaba_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vaba_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[3, 4]).map_err(|e| format!("{e} | call: vaba_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaba_s32(create_random_int32x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vaba_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vaba_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vaba_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaba_s8(create_random_int8x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vaba_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vaba_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[5, 6, 7, 8]).map_err(|e| format!("{e} | call: vaba_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaba_u16(create_random_uint16x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vaba_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vaba_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[3, 4]).map_err(|e| format!("{e} | call: vaba_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaba_u32(create_random_uint32x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vaba_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vaba_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vaba_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaba_u8(create_random_uint8x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabal_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vabal_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vabal_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabal_s8(create_random_int16x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabal_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vabal_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[5, 6, 7, 8]).map_err(|e| format!("{e} | call: vabal_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabal_s16(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabal_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vabal_s32(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[3, 4]).map_err(|e| format!("{e} | call: vabal_s32(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabal_s32(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabal_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vabal_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vabal_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabal_u8(create_random_uint16x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabal_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vabal_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[5, 6, 7, 8]).map_err(|e| format!("{e} | call: vabal_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabal_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabal_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vabal_u32(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[3, 4]).map_err(|e| format!("{e} | call: vabal_u32(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabal_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabaq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vabaq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vabaq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabaq_s16(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabaq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vabaq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[5, 6, 7, 8]).map_err(|e| format!("{e} | call: vabaq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabaq_s32(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabaq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vabaq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create_int8x16_t_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]).map_err(|e| format!("{e} | call: vabaq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create_int8x16_t_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabaq_s8(create_random_int8x16_t(), create_random_int8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabaq_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vabaq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vabaq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabaq_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabaq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vabaq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[5, 6, 7, 8]).map_err(|e| format!("{e} | call: vabaq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabaq_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabaq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vabaq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create_uint8x16_t_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]).map_err(|e| format!("{e} | call: vabaq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create_uint8x16_t_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabaq_u8(create_random_uint8x16_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabd_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vabd_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[2.0, 2.0]).map_err(|e| format!("{e} | call: vabd_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabd_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabdq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vabdq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[4.0, 4.0, 4.0, 4.0]).map_err(|e| format!("{e} | call: vabdq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdq_f32(create_random_float32x4_t(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabd_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vabd_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 8, 8, 8, 8, 8, 8, 8]).map_err(|e| format!("{e} | call: vabd_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabd_s8(create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabdq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vabdq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16]).map_err(|e| format!("{e} | call: vabdq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdq_s8(create_random_int8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabd_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vabd_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 4, 4, 4]).map_err(|e| format!("{e} | call: vabd_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabd_s16(create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabdq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vabdq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 8, 8, 8, 8, 8, 8, 8]).map_err(|e| format!("{e} | call: vabdq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdq_s16(create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabd_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vabd_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[2, 2]).map_err(|e| format!("{e} | call: vabd_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabd_s32(create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabdq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vabdq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 4, 4, 4]).map_err(|e| format!("{e} | call: vabdq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdq_s32(create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabd_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vabd_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 8, 8, 8, 8, 8, 8, 8]).map_err(|e| format!("{e} | call: vabd_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabd_u8(create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabdq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vabdq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16]).map_err(|e| format!("{e} | call: vabdq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdq_u8(create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabd_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vabd_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 4, 4, 4]).map_err(|e| format!("{e} | call: vabd_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabd_u16(create_random_uint16x4_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabdq_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vabdq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 8, 8, 8, 8, 8, 8, 8]).map_err(|e| format!("{e} | call: vabdq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdq_u16(create_random_uint16x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabd_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vabd_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[2, 2]).map_err(|e| format!("{e} | call: vabd_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabd_u32(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabdq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vabdq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 4, 4, 4]).map_err(|e| format!("{e} | call: vabdq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdq_u32(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabdl_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vabdl_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 8, 8, 8, 8, 8, 8, 8]).map_err(|e| format!("{e} | call: vabdl_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdl_s8(create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabdl_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vabdl_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 4, 4, 4]).map_err(|e| format!("{e} | call: vabdl_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdl_s16(create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabdl_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vabdl_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[2, 2]).map_err(|e| format!("{e} | call: vabdl_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdl_s32(create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabdl_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vabdl_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 8, 8, 8, 8, 8, 8, 8]).map_err(|e| format!("{e} | call: vabdl_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdl_u8(create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabdl_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vabdl_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 4, 4, 4]).map_err(|e| format!("{e} | call: vabdl_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdl_u16(create_random_uint16x4_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabdl_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vabdl_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[2, 2]).map_err(|e| format!("{e} | call: vabdl_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdl_u32(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabs_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vabs_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vabs_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabs_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabsq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vabsq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: vabsq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabsq_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabs_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vabs_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vabs_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabs_s8(create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vabsq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vabsq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vabsq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabsq_s8(create_random_int8x16_t());
            }
        }
    }
    Ok(())
}
