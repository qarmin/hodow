use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s64(create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[5e-324, 1e-323]).map_err(|e| format!("{e} | call: vreinterpretq_f64_s64(create_int64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_f64_s64(create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_s64(create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vreinterpretq_p64_s64(create_int64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_p64_s64(create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u64(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[5e-324]).map_err(|e| format!("{e} | call: vreinterpret_f64_u64(create_uint64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_f64_u64(create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_u64(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vreinterpret_p64_u64(create_uint64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_p64_u64(create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u64(create_uint64x2_t_from([1, 2])));
        check_array_equality(&result, &[5e-324, 1e-323]).map_err(|e| format!("{e} | call: vreinterpretq_f64_u64(create_uint64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_f64_u64(create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_u64(create_uint64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vreinterpretq_p64_u64(create_uint64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_p64_u64(create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p64(create_poly64x1_t_from([1])));
        check_array_equality(&result, &[5e-324]).map_err(|e| format!("{e} | call: vreinterpret_f64_p64(create_poly64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_f64_p64(create_random_poly64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_s64_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vreinterpret_s64_p64(create_poly64x1_t_from([1])));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vreinterpret_s64_p64(create_poly64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_s64_p64(create_random_poly64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_u64_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_p64(create_poly64x1_t_from([1])));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vreinterpret_u64_p64(create_poly64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_u64_p64(create_random_poly64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p64(create_poly64x2_t_from([1, 2])));
        check_array_equality(&result, &[5e-324, 1e-323]).map_err(|e| format!("{e} | call: vreinterpretq_f64_p64(create_poly64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_f64_p64(create_random_poly64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_s64_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_p64(create_poly64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vreinterpretq_s64_p64(create_poly64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_s64_p64(create_random_poly64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_u64_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_p64(create_poly64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vreinterpretq_u64_p64(create_poly64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_u64_p64(create_random_poly64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p128() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p128(1u128));
        check_array_equality(&result, &[5e-324, 0.0]).map_err(|e| format!("{e} | call: vreinterpretq_f64_p128(1u128)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_f64_p128(rand::random::<u128>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[2.000000473111868]).map_err(|e| format!("{e} | call: vreinterpret_f64_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_f64_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[4611686019492741120]).map_err(|e| format!("{e} | call: vreinterpret_p64_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_p64_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[2.000000473111868, 512.0001225471497]).map_err(|e| format!("{e} | call: vreinterpretq_f64_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_f64_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[4611686019492741120, 4647714816524288000]).map_err(|e| format!("{e} | call: vreinterpretq_p64_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_p64_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_f32_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vreinterpret_f32_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0.0, 1.875]).map_err(|e| format!("{e} | call: vreinterpret_f32_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_f32_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_s8_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vreinterpret_s8_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, -16, 63]).map_err(|e| format!("{e} | call: vreinterpret_s8_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_s8_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_s16_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vreinterpret_s16_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0, 0, 0, 16368]).map_err(|e| format!("{e} | call: vreinterpret_s16_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_s16_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_s32_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vreinterpret_s32_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0, 1072693248]).map_err(|e| format!("{e} | call: vreinterpret_s32_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_s32_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_u8_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vreinterpret_u8_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 240, 63]).map_err(|e| format!("{e} | call: vreinterpret_u8_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_u8_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_u16_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vreinterpret_u16_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0, 0, 0, 16368]).map_err(|e| format!("{e} | call: vreinterpret_u16_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_u16_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_u32_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vreinterpret_u32_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0, 1072693248]).map_err(|e| format!("{e} | call: vreinterpret_u32_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_u32_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_p8_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vreinterpret_p8_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 240, 63]).map_err(|e| format!("{e} | call: vreinterpret_p8_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_p8_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_p16_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vreinterpret_p16_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0, 0, 0, 16368]).map_err(|e| format!("{e} | call: vreinterpret_p16_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_p16_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_p128_f64() -> Result<(), String> {
    unsafe {
        let _result = vreinterpretq_p128_f64(create_float64x2_t_from([1.0, 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_p128_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_f32_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0, 1.875, 0.0, 2.0]).map_err(|e| format!("{e} | call: vreinterpretq_f32_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_f32_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_s8_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vreinterpretq_s8_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, -16, 63, 0, 0, 0, 0, 0, 0, 0, 64]).map_err(|e| format!("{e} | call: vreinterpretq_s8_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_s8_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_s16_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vreinterpretq_s16_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 0, 0, 16368, 0, 0, 0, 16384]).map_err(|e| format!("{e} | call: vreinterpretq_s16_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_s16_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_s32_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vreinterpretq_s32_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 1072693248, 0, 1073741824]).map_err(|e| format!("{e} | call: vreinterpretq_s32_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_s32_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_u8_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vreinterpretq_u8_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 240, 63, 0, 0, 0, 0, 0, 0, 0, 64]).map_err(|e| format!("{e} | call: vreinterpretq_u8_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_u8_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_u16_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vreinterpretq_u16_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 0, 0, 16368, 0, 0, 0, 16384]).map_err(|e| format!("{e} | call: vreinterpretq_u16_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_u16_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_u32_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vreinterpretq_u32_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 1072693248, 0, 1073741824]).map_err(|e| format!("{e} | call: vreinterpretq_u32_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_u32_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_p8_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vreinterpretq_p8_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 240, 63, 0, 0, 0, 0, 0, 0, 0, 64]).map_err(|e| format!("{e} | call: vreinterpretq_p8_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_p8_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_p16_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vreinterpretq_p16_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 0, 0, 16368, 0, 0, 0, 16384]).map_err(|e| format!("{e} | call: vreinterpretq_p16_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_p16_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[5.447603722011605e-270]).map_err(|e| format!("{e} | call: vreinterpret_f64_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_f64_s8(create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[5.447603722011605e-270, 2.500364306227096e-231]).map_err(|e| format!("{e} | call: vreinterpretq_f64_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_f64_s8(create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s16(create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[5.56274830678932e-309]).map_err(|e| format!("{e} | call: vreinterpret_f64_s16(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_f64_s16(create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[5.56274830678932e-309, 1.1125517834184144e-308]).map_err(|e| format!("{e} | call: vreinterpretq_f64_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_f64_s16(create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s32(create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[4.2439915824e-314]).map_err(|e| format!("{e} | call: vreinterpret_f64_s32(create_int32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_f64_s32(create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s32(create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[4.2439915824e-314, 8.4879831653e-314]).map_err(|e| format!("{e} | call: vreinterpretq_f64_s32(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_f64_s32(create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[5.447603722011605e-270]).map_err(|e| format!("{e} | call: vreinterpret_f64_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_f64_u8(create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[5.447603722011605e-270, 2.500364306227096e-231]).map_err(|e| format!("{e} | call: vreinterpretq_f64_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_f64_u8(create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u16(create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[5.56274830678932e-309]).map_err(|e| format!("{e} | call: vreinterpret_f64_u16(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_f64_u16(create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[5.56274830678932e-309, 1.1125517834184144e-308]).map_err(|e| format!("{e} | call: vreinterpretq_f64_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_f64_u16(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u32(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[4.2439915824e-314]).map_err(|e| format!("{e} | call: vreinterpret_f64_u32(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_f64_u32(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u32(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[4.2439915824e-314, 8.4879831653e-314]).map_err(|e| format!("{e} | call: vreinterpretq_f64_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_f64_u32(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p8(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[5.447603722011605e-270]).map_err(|e| format!("{e} | call: vreinterpret_f64_p8(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_f64_p8(create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p8(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[5.447603722011605e-270, 2.500364306227096e-231]).map_err(|e| format!("{e} | call: vreinterpretq_f64_p8(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_f64_p8(create_random_poly8x16_t());
            }
        }
    }
    Ok(())
}
