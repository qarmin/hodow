use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_neon_crc32cd() -> Result<(), String> {
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

pub(super) fn test_aarch64_neon_crc32d() -> Result<(), String> {
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

pub(super) fn test_aarch64_neon_jcvt() -> Result<(), String> {
    unsafe {
        let result = __jcvt(1.0f64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: __jcvt(1.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __jcvt(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabal_high_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vabal_high_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_int8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40])));
        check_array_equality(&result, &[17, 18, 19, 20, 21, 22, 23, 24]).map_err(|e| format!("{e} | call: vabal_high_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_int8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabal_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabal_high_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vabal_high_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[9, 10, 11, 12]).map_err(|e| format!("{e} | call: vabal_high_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabal_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabal_high_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vabal_high_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[5, 6]).map_err(|e| format!("{e} | call: vabal_high_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabal_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabal_high_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vabal_high_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_uint8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40])));
        check_array_equality(&result, &[17, 18, 19, 20, 21, 22, 23, 24]).map_err(|e| format!("{e} | call: vabal_high_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_uint8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabal_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabal_high_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vabal_high_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[9, 10, 11, 12]).map_err(|e| format!("{e} | call: vabal_high_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabal_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabal_high_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vabal_high_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[5, 6]).map_err(|e| format!("{e} | call: vabal_high_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabal_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabd_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vabd_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0])));
        check_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: vabd_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabd_f64(create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabdq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vabdq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[2.0, 2.0]).map_err(|e| format!("{e} | call: vabdq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdq_f64(create_random_float64x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabdd_f64() -> Result<(), String> {
    unsafe {
        let _result = vabdd_f64(1.0f64, 2.0f64);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdd_f64(rand::random::<f64>(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabds_f32() -> Result<(), String> {
    unsafe {
        let _result = vabds_f32(1.0f32, 2.0f32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabds_f32(rand::random::<f32>(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabdl_high_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vabdl_high_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[16, 16, 16, 16, 16, 16, 16, 16]).map_err(|e| format!("{e} | call: vabdl_high_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdl_high_s8(create_random_int8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabdl_high_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vabdl_high_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 8, 8, 8]).map_err(|e| format!("{e} | call: vabdl_high_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdl_high_s16(create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabdl_high_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vabdl_high_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 4]).map_err(|e| format!("{e} | call: vabdl_high_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdl_high_s32(create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabdl_high_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vabdl_high_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[16, 16, 16, 16, 16, 16, 16, 16]).map_err(|e| format!("{e} | call: vabdl_high_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdl_high_u8(create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabdl_high_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vabdl_high_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 8, 8, 8]).map_err(|e| format!("{e} | call: vabdl_high_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdl_high_u16(create_random_uint16x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabdl_high_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vabdl_high_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 4]).map_err(|e| format!("{e} | call: vabdl_high_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabdl_high_u32(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabs_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vabs_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: vabs_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabs_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabsq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vabsq_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vabsq_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabsq_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabs_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vabs_s64(create_int64x1_t_from([1])));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vabs_s64(create_int64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabs_s64(create_random_int64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabsq_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vabsq_s64(create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vabsq_s64(create_int64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabsq_s64(create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vabsd_s64() -> Result<(), String> {
    unsafe {
        let result = vabsd_s64(1i64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vabsd_s64(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vabsd_s64(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddd_s64() -> Result<(), String> {
    unsafe {
        let result = vaddd_s64(1i64, 2i64);
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: vaddd_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddd_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddd_u64() -> Result<(), String> {
    unsafe {
        let result = vaddd_u64(1u64, 2u64);
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: vaddd_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddd_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddlv_s16() -> Result<(), String> {
    unsafe {
        let result = vaddlv_s16(create_int16x4_t_from([1, 2, 3, 4]));
        check_int_equality(result as i32, 10).map_err(|e| format!("{e} | call: vaddlv_s16(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddlv_s16(create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddlvq_s16() -> Result<(), String> {
    unsafe {
        let result = vaddlvq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 36).map_err(|e| format!("{e} | call: vaddlvq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddlvq_s16(create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddlvq_s32() -> Result<(), String> {
    unsafe {
        let result = vaddlvq_s32(create_int32x4_t_from([1, 2, 3, 4]));
        check_int_equality(result as i32, 10).map_err(|e| format!("{e} | call: vaddlvq_s32(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddlvq_s32(create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddlv_s32() -> Result<(), String> {
    unsafe {
        let result = vaddlv_s32(create_int32x2_t_from([1, 2]));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: vaddlv_s32(create_int32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddlv_s32(create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddlv_s8() -> Result<(), String> {
    unsafe {
        let result = vaddlv_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 36).map_err(|e| format!("{e} | call: vaddlv_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddlv_s8(create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddlvq_s8() -> Result<(), String> {
    unsafe {
        let result = vaddlvq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result as i32, 136).map_err(|e| format!("{e} | call: vaddlvq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddlvq_s8(create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddlv_u16() -> Result<(), String> {
    unsafe {
        let result = vaddlv_u16(create_uint16x4_t_from([1, 2, 3, 4]));
        check_int_equality(result as i32, 10).map_err(|e| format!("{e} | call: vaddlv_u16(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddlv_u16(create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddlvq_u16() -> Result<(), String> {
    unsafe {
        let result = vaddlvq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 36).map_err(|e| format!("{e} | call: vaddlvq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddlvq_u16(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddlvq_u32() -> Result<(), String> {
    unsafe {
        let result = vaddlvq_u32(create_uint32x4_t_from([1, 2, 3, 4]));
        check_int_equality(result as i32, 10).map_err(|e| format!("{e} | call: vaddlvq_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddlvq_u32(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddlv_u32() -> Result<(), String> {
    unsafe {
        let result = vaddlv_u32(create_uint32x2_t_from([1, 2]));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: vaddlv_u32(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddlv_u32(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddlv_u8() -> Result<(), String> {
    unsafe {
        let result = vaddlv_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 36).map_err(|e| format!("{e} | call: vaddlv_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddlv_u8(create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddlvq_u8() -> Result<(), String> {
    unsafe {
        let result = vaddlvq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result as i32, 136).map_err(|e| format!("{e} | call: vaddlvq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddlvq_u8(create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddv_f32() -> Result<(), String> {
    unsafe {
        let _result = vaddv_f32(create_float32x2_t_from([1.0, 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddv_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddvq_f32() -> Result<(), String> {
    unsafe {
        let _result = vaddvq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddvq_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddvq_f64() -> Result<(), String> {
    unsafe {
        let _result = vaddvq_f64(create_float64x2_t_from([1.0, 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddvq_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddv_s32() -> Result<(), String> {
    unsafe {
        let result = vaddv_s32(create_int32x2_t_from([1, 2]));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: vaddv_s32(create_int32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddv_s32(create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddv_s8() -> Result<(), String> {
    unsafe {
        let result = vaddv_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 36).map_err(|e| format!("{e} | call: vaddv_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddv_s8(create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddvq_s8() -> Result<(), String> {
    unsafe {
        let result = vaddvq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result as i32, -120).map_err(|e| format!("{e} | call: vaddvq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddvq_s8(create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddv_s16() -> Result<(), String> {
    unsafe {
        let result = vaddv_s16(create_int16x4_t_from([1, 2, 3, 4]));
        check_int_equality(result as i32, 10).map_err(|e| format!("{e} | call: vaddv_s16(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddv_s16(create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddvq_s16() -> Result<(), String> {
    unsafe {
        let result = vaddvq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 36).map_err(|e| format!("{e} | call: vaddvq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddvq_s16(create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddvq_s32() -> Result<(), String> {
    unsafe {
        let result = vaddvq_s32(create_int32x4_t_from([1, 2, 3, 4]));
        check_int_equality(result as i32, 10).map_err(|e| format!("{e} | call: vaddvq_s32(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddvq_s32(create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddv_u32() -> Result<(), String> {
    unsafe {
        let result = vaddv_u32(create_uint32x2_t_from([1, 2]));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: vaddv_u32(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddv_u32(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddv_u8() -> Result<(), String> {
    unsafe {
        let result = vaddv_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 36).map_err(|e| format!("{e} | call: vaddv_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddv_u8(create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vaddvq_u8() -> Result<(), String> {
    unsafe {
        let result = vaddvq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result as i32, 136).map_err(|e| format!("{e} | call: vaddvq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaddvq_u8(create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}
