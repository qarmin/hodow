use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_neon_vceqs_f32() -> Result<(), String> {
    unsafe {
        let result = vceqs_f32(1.0f32, 2.0f32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vceqs_f32(1.0f32, 2.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqs_f32(rand::random::<f32>(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqd_s64() -> Result<(), String> {
    unsafe {
        let result = vceqd_s64(1i64, 2i64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vceqd_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqd_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqd_u64() -> Result<(), String> {
    unsafe {
        let result = vceqd_u64(1u64, 2u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vceqd_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqd_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqz_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vceqz_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0u32; 2]).map_err(|e| format!("{e} | call: vceqz_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqz_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqzq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vceqzq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0u32; 4]).map_err(|e| format!("{e} | call: vceqzq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqzq_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqz_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vceqz_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vceqz_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqz_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqzq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vceqzq_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vceqzq_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqzq_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqz_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vceqz_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0u8; 8]).map_err(|e| format!("{e} | call: vceqz_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqz_s8(create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqzq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vceqzq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0u8; 16]).map_err(|e| format!("{e} | call: vceqzq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqzq_s8(create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqz_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vceqz_s16(create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0u16; 4]).map_err(|e| format!("{e} | call: vceqz_s16(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqz_s16(create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqzq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vceqzq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0u16; 8]).map_err(|e| format!("{e} | call: vceqzq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqzq_s16(create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqz_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vceqz_s32(create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[0u32; 2]).map_err(|e| format!("{e} | call: vceqz_s32(create_int32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqz_s32(create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqzq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vceqzq_s32(create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0u32; 4]).map_err(|e| format!("{e} | call: vceqzq_s32(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqzq_s32(create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqz_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vceqz_s64(create_int64x1_t_from([1])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vceqz_s64(create_int64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqz_s64(create_random_int64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqzq_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vceqzq_s64(create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vceqzq_s64(create_int64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqzq_s64(create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqz_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vceqz_p8(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0u8; 8]).map_err(|e| format!("{e} | call: vceqz_p8(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqz_p8(create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqzq_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vceqzq_p8(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0u8; 16]).map_err(|e| format!("{e} | call: vceqzq_p8(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqzq_p8(create_random_poly8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqz_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vceqz_p64(create_poly64x1_t_from([1])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vceqz_p64(create_poly64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqz_p64(create_random_poly64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqzq_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vceqzq_p64(create_poly64x2_t_from([1, 2])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vceqzq_p64(create_poly64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqzq_p64(create_random_poly64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqz_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vceqz_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0u8; 8]).map_err(|e| format!("{e} | call: vceqz_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqz_u8(create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqzq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vceqzq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0u8; 16]).map_err(|e| format!("{e} | call: vceqzq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqzq_u8(create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqz_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vceqz_u16(create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0u16; 4]).map_err(|e| format!("{e} | call: vceqz_u16(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqz_u16(create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqzq_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vceqzq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0u16; 8]).map_err(|e| format!("{e} | call: vceqzq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqzq_u16(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqz_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vceqz_u32(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[0u32; 2]).map_err(|e| format!("{e} | call: vceqz_u32(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqz_u32(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqzq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vceqzq_u32(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0u32; 4]).map_err(|e| format!("{e} | call: vceqzq_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqzq_u32(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqz_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vceqz_u64(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vceqz_u64(create_uint64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqz_u64(create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqzq_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vceqzq_u64(create_uint64x2_t_from([1, 2])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vceqzq_u64(create_uint64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqzq_u64(create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqzd_s64() -> Result<(), String> {
    unsafe {
        let result = vceqzd_s64(1i64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vceqzd_s64(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqzd_s64(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqzd_u64() -> Result<(), String> {
    unsafe {
        let result = vceqzd_u64(1u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vceqzd_u64(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqzd_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqzs_f32() -> Result<(), String> {
    unsafe {
        let result = vceqzs_f32(1.0f32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vceqzs_f32(1.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqzs_f32(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vceqzd_f64() -> Result<(), String> {
    unsafe {
        let result = vceqzd_f64(1.0f64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vceqzd_f64(1.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vceqzd_f64(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcge_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcge_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vcge_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcge_f64(create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgeq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcgeq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vcgeq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgeq_f64(create_random_float64x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcge_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcge_s64(create_int64x1_t_from([1]), create_int64x1_t_from([2])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vcge_s64(create_int64x1_t_from([1]), create_int64x1_t_from([2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcge_s64(create_random_int64x1_t(), create_random_int64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgeq_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcgeq_s64(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vcgeq_s64(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgeq_s64(create_random_int64x2_t(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcge_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcge_u64(create_uint64x1_t_from([1]), create_uint64x1_t_from([2])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vcge_u64(create_uint64x1_t_from([1]), create_uint64x1_t_from([2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcge_u64(create_random_uint64x1_t(), create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgeq_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcgeq_u64(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vcgeq_u64(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgeq_u64(create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcged_f64() -> Result<(), String> {
    unsafe {
        let result = vcged_f64(1.0f64, 2.0f64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vcged_f64(1.0f64, 2.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcged_f64(rand::random::<f64>(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcges_f32() -> Result<(), String> {
    unsafe {
        let result = vcges_f32(1.0f32, 2.0f32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vcges_f32(1.0f32, 2.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcges_f32(rand::random::<f32>(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcged_s64() -> Result<(), String> {
    unsafe {
        let result = vcged_s64(1i64, 2i64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vcged_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcged_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcged_u64() -> Result<(), String> {
    unsafe {
        let result = vcged_u64(1u64, 2u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vcged_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcged_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgez_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcgez_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| format!("{e} | call: vcgez_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgez_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgezq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcgezq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| format!("{e} | call: vcgezq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgezq_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgez_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcgez_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: vcgez_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgez_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgezq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcgezq_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| format!("{e} | call: vcgezq_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgezq_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgez_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcgez_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| format!("{e} | call: vcgez_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgez_s8(create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgezq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vcgezq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| format!("{e} | call: vcgezq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgezq_s8(create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgez_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcgez_s16(create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535]).map_err(|e| format!("{e} | call: vcgez_s16(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgez_s16(create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgezq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vcgezq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| format!("{e} | call: vcgezq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgezq_s16(create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcgez_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcgez_s32(create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| format!("{e} | call: vcgez_s32(create_int32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcgez_s32(create_random_int32x2_t());
            }
        }
    }
    Ok(())
}
