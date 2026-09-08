#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_arm_shared_neon_vreinterpret_u32_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vreinterpret_u32_u16(create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[131073, 262147]).map_err(|e| format!("{e} | call: vreinterpret_u32_u16(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_u32_u16(create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_u64_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_u16(create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1125912791875585]).map_err(|e| format!("{e} | call: vreinterpret_u64_u16(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_u64_u16(create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_p8_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vreinterpret_p8_u16(create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0]).map_err(|e| format!("{e} | call: vreinterpret_p8_u16(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_p8_u16(create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_p64_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_u16(create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1125912791875585]).map_err(|e| format!("{e} | call: vreinterpret_p64_u16(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_p64_u16(create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_p128_u16() -> Result<(), String> {
    unsafe {
        let _result = vreinterpretq_p128_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_p128_u16(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_f32_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1.83672e-40, 3.67346e-40, 5.5102e-40, 7.34694e-40]).map_err(|e| format!("{e} | call: vreinterpretq_f32_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_f32_u16(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_s8_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vreinterpretq_s8_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0]).map_err(|e| format!("{e} | call: vreinterpretq_s8_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_s8_u16(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_s32_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vreinterpretq_s32_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[131073, 262147, 393221, 524295]).map_err(|e| format!("{e} | call: vreinterpretq_s32_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_s32_u16(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_s64_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1125912791875585, 2251829878849541]).map_err(|e| format!("{e} | call: vreinterpretq_s64_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_s64_u16(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_u8_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vreinterpretq_u8_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0]).map_err(|e| format!("{e} | call: vreinterpretq_u8_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_u8_u16(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_u32_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vreinterpretq_u32_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[131073, 262147, 393221, 524295]).map_err(|e| format!("{e} | call: vreinterpretq_u32_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_u32_u16(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_u64_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1125912791875585, 2251829878849541]).map_err(|e| format!("{e} | call: vreinterpretq_u64_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_u64_u16(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_p8_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vreinterpretq_p8_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0]).map_err(|e| format!("{e} | call: vreinterpretq_p8_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_p8_u16(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_p64_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1125912791875585, 2251829878849541]).map_err(|e| format!("{e} | call: vreinterpretq_p64_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_p64_u16(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_s8_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vreinterpret_s8_u32(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpret_s8_u32(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_s8_u32(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_s16_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vreinterpret_s16_u32(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 0, 2, 0]).map_err(|e| format!("{e} | call: vreinterpret_s16_u32(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_s16_u32(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_s64_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vreinterpret_s64_u32(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[8589934593]).map_err(|e| format!("{e} | call: vreinterpret_s64_u32(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_s64_u32(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_u8_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vreinterpret_u8_u32(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpret_u8_u32(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_u8_u32(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_u16_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vreinterpret_u16_u32(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 0, 2, 0]).map_err(|e| format!("{e} | call: vreinterpret_u16_u32(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_u16_u32(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_u64_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_u32(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[8589934593]).map_err(|e| format!("{e} | call: vreinterpret_u64_u32(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_u64_u32(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_p8_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vreinterpret_p8_u32(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpret_p8_u32(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_p8_u32(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_p16_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vreinterpret_p16_u32(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 0, 2, 0]).map_err(|e| format!("{e} | call: vreinterpret_p16_u32(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_p16_u32(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_p64_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_u32(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[8589934593]).map_err(|e| format!("{e} | call: vreinterpret_p64_u32(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_p64_u32(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_p128_u32() -> Result<(), String> {
    unsafe {
        let _result = vreinterpretq_p128_u32(create_uint32x4_t_from([1, 2, 3, 4]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_p128_u32(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_s8_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vreinterpretq_s8_u32(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpretq_s8_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_s8_u32(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_s16_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vreinterpretq_s16_u32(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0]).map_err(|e| format!("{e} | call: vreinterpretq_s16_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_s16_u32(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_s64_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_u32(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[8589934593, 17179869187]).map_err(|e| format!("{e} | call: vreinterpretq_s64_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_s64_u32(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_u8_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vreinterpretq_u8_u32(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpretq_u8_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_u8_u32(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_u16_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vreinterpretq_u16_u32(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0]).map_err(|e| format!("{e} | call: vreinterpretq_u16_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_u16_u32(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_u64_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_u32(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[8589934593, 17179869187]).map_err(|e| format!("{e} | call: vreinterpretq_u64_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_u64_u32(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_p8_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vreinterpretq_p8_u32(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpretq_p8_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_p8_u32(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_p16_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vreinterpretq_p16_u32(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0]).map_err(|e| format!("{e} | call: vreinterpretq_p16_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_p16_u32(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_p64_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_u32(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[8589934593, 17179869187]).map_err(|e| format!("{e} | call: vreinterpretq_p64_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_p64_u32(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_f32_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vreinterpret_f32_u64(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[1e-45, 0.0]).map_err(|e| format!("{e} | call: vreinterpret_f32_u64(create_uint64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_f32_u64(create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_s8_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vreinterpret_s8_u64(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpret_s8_u64(create_uint64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_s8_u64(create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_s16_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vreinterpret_s16_u64(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpret_s16_u64(create_uint64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_s16_u64(create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_s32_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vreinterpret_s32_u64(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: vreinterpret_s32_u64(create_uint64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_s32_u64(create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_u8_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vreinterpret_u8_u64(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpret_u8_u64(create_uint64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_u8_u64(create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_u16_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vreinterpret_u16_u64(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpret_u16_u64(create_uint64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_u16_u64(create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_u32_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vreinterpret_u32_u64(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: vreinterpret_u32_u64(create_uint64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_u32_u64(create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_p8_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vreinterpret_p8_u64(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpret_p8_u64(create_uint64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_p8_u64(create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpret_p16_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vreinterpret_p16_u64(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpret_p16_u64(create_uint64x1_t_from([1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpret_p16_u64(create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_p128_u64() -> Result<(), String> {
    unsafe {
        let _result = vreinterpretq_p128_u64(create_uint64x2_t_from([1, 2]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_p128_u64(create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_f32_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_u64(create_uint64x2_t_from([1, 2])));
        check_array_equality(&result, &[1e-45, 0.0, 3e-45, 0.0]).map_err(|e| format!("{e} | call: vreinterpretq_f32_u64(create_uint64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_f32_u64(create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_s8_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vreinterpretq_s8_u64(create_uint64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpretq_s8_u64(create_uint64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_s8_u64(create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_s16_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vreinterpretq_s16_u64(create_uint64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpretq_s16_u64(create_uint64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_s16_u64(create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_s32_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vreinterpretq_s32_u64(create_uint64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 0, 2, 0]).map_err(|e| format!("{e} | call: vreinterpretq_s32_u64(create_uint64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_s32_u64(create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_u8_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vreinterpretq_u8_u64(create_uint64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpretq_u8_u64(create_uint64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_u8_u64(create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_u16_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vreinterpretq_u16_u64(create_uint64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpretq_u16_u64(create_uint64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_u16_u64(create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vreinterpretq_u32_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vreinterpretq_u32_u64(create_uint64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 0, 2, 0]).map_err(|e| format!("{e} | call: vreinterpretq_u32_u64(create_uint64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_u32_u64(create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}
