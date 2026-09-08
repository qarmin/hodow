use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_neon_vcgezq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcgezq_s32(create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| format!("{e} | call: vcgezq_s32(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgezq_s32(create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgez_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcgez_s64(create_int64x1_t_from([1])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: vcgez_s64(create_int64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgez_s64(create_random_int64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgezq_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcgezq_s64(create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| format!("{e} | call: vcgezq_s64(create_int64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgezq_s64(create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgezd_f64() -> Result<(), String> {
    unsafe {
        let result = vcgezd_f64(1.0f64);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vcgezd_f64(1.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgezd_f64(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgezs_f32() -> Result<(), String> {
    unsafe {
        let result = vcgezs_f32(1.0f32);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vcgezs_f32(1.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgezs_f32(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgezd_s64() -> Result<(), String> {
    unsafe {
        let result = vcgezd_s64(1i64);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vcgezd_s64(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgezd_s64(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgt_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcgt_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vcgt_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgt_f64(create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcgtq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vcgtq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtq_f64(create_random_float64x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgt_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcgt_s64(create_int64x1_t_from([1]), create_int64x1_t_from([2])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vcgt_s64(create_int64x1_t_from([1]), create_int64x1_t_from([2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgt_s64(create_random_int64x1_t(), create_random_int64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtq_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcgtq_s64(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vcgtq_s64(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtq_s64(create_random_int64x2_t(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgt_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcgt_u64(create_uint64x1_t_from([1]), create_uint64x1_t_from([2])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vcgt_u64(create_uint64x1_t_from([1]), create_uint64x1_t_from([2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgt_u64(create_random_uint64x1_t(), create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtq_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcgtq_u64(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vcgtq_u64(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtq_u64(create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtd_f64() -> Result<(), String> {
    unsafe {
        let result = vcgtd_f64(1.0f64, 2.0f64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vcgtd_f64(1.0f64, 2.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtd_f64(rand::random::<f64>(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgts_f32() -> Result<(), String> {
    unsafe {
        let result = vcgts_f32(1.0f32, 2.0f32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vcgts_f32(1.0f32, 2.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgts_f32(rand::random::<f32>(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtd_s64() -> Result<(), String> {
    unsafe {
        let result = vcgtd_s64(1i64, 2i64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vcgtd_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtd_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtd_u64() -> Result<(), String> {
    unsafe {
        let result = vcgtd_u64(1u64, 2u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vcgtd_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtd_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtz_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcgtz_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| format!("{e} | call: vcgtz_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtz_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtzq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcgtzq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| format!("{e} | call: vcgtzq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtzq_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtz_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcgtz_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: vcgtz_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtz_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtzq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcgtzq_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| format!("{e} | call: vcgtzq_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtzq_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtz_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcgtz_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| format!("{e} | call: vcgtz_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtz_s8(create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtzq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vcgtzq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| format!("{e} | call: vcgtzq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtzq_s8(create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtz_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcgtz_s16(create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535]).map_err(|e| format!("{e} | call: vcgtz_s16(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtz_s16(create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtzq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vcgtzq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| format!("{e} | call: vcgtzq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtzq_s16(create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtz_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcgtz_s32(create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| format!("{e} | call: vcgtz_s32(create_int32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtz_s32(create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtzq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcgtzq_s32(create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| format!("{e} | call: vcgtzq_s32(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtzq_s32(create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtz_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcgtz_s64(create_int64x1_t_from([1])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: vcgtz_s64(create_int64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtz_s64(create_random_int64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtzq_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcgtzq_s64(create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| format!("{e} | call: vcgtzq_s64(create_int64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtzq_s64(create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtzd_f64() -> Result<(), String> {
    unsafe {
        let result = vcgtzd_f64(1.0f64);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vcgtzd_f64(1.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtzd_f64(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtzs_f32() -> Result<(), String> {
    unsafe {
        let result = vcgtzs_f32(1.0f32);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vcgtzs_f32(1.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtzs_f32(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgtzd_s64() -> Result<(), String> {
    unsafe {
        let result = vcgtzd_s64(1i64);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vcgtzd_s64(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgtzd_s64(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcle_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcle_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: vcle_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcle_f64(create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcleq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcleq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| format!("{e} | call: vcleq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcleq_f64(create_random_float64x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcle_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcle_s64(create_int64x1_t_from([1]), create_int64x1_t_from([2])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: vcle_s64(create_int64x1_t_from([1]), create_int64x1_t_from([2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcle_s64(create_random_int64x1_t(), create_random_int64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcleq_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcleq_s64(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| format!("{e} | call: vcleq_s64(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcleq_s64(create_random_int64x2_t(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcle_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcle_u64(create_uint64x1_t_from([1]), create_uint64x1_t_from([2])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: vcle_u64(create_uint64x1_t_from([1]), create_uint64x1_t_from([2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcle_u64(create_random_uint64x1_t(), create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcleq_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcleq_u64(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| format!("{e} | call: vcleq_u64(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcleq_u64(create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcled_f64() -> Result<(), String> {
    unsafe {
        let result = vcled_f64(1.0f64, 2.0f64);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vcled_f64(1.0f64, 2.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcled_f64(rand::random::<f64>(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcles_f32() -> Result<(), String> {
    unsafe {
        let result = vcles_f32(1.0f32, 2.0f32);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vcles_f32(1.0f32, 2.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcles_f32(rand::random::<f32>(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcled_u64() -> Result<(), String> {
    unsafe {
        let result = vcled_u64(1u64, 2u64);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vcled_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcled_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcled_s64() -> Result<(), String> {
    unsafe {
        let result = vcled_s64(1i64, 2i64);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vcled_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcled_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vclez_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vclez_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0u32; 2]).map_err(|e| format!("{e} | call: vclez_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vclez_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vclezq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vclezq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0u32; 4]).map_err(|e| format!("{e} | call: vclezq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vclezq_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vclez_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vclez_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vclez_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vclez_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vclezq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vclezq_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vclezq_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vclezq_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vclez_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vclez_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0u8; 8]).map_err(|e| format!("{e} | call: vclez_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vclez_s8(create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vclezq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vclezq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0u8; 16]).map_err(|e| format!("{e} | call: vclezq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vclezq_s8(create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vclez_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vclez_s16(create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0u16; 4]).map_err(|e| format!("{e} | call: vclez_s16(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vclez_s16(create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vclezq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vclezq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0u16; 8]).map_err(|e| format!("{e} | call: vclezq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vclezq_s16(create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vclez_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vclez_s32(create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[0u32; 2]).map_err(|e| format!("{e} | call: vclez_s32(create_int32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vclez_s32(create_random_int32x2_t());
            }
        }
    }
    Ok(())
}
