#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_arm_shared_neon_vmov_n_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vmov_n_p8(1u8));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vmov_n_p8(1u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmov_n_p8(rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmov_n_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vmov_n_s16(1i16));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vmov_n_s16(1i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmov_n_s16(rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmov_n_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vmov_n_s32(1i32));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vmov_n_s32(1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmov_n_s32(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmov_n_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vmov_n_s64(1i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vmov_n_s64(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmov_n_s64(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmov_n_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vmov_n_s8(1i8));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vmov_n_s8(1i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmov_n_s8(rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmov_n_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vmov_n_u16(1u16));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vmov_n_u16(1u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmov_n_u16(rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmov_n_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vmov_n_u32(1u32));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vmov_n_u32(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmov_n_u32(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmov_n_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vmov_n_u64(1u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vmov_n_u64(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmov_n_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmov_n_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vmov_n_u8(1u8));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vmov_n_u8(1u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmov_n_u8(rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovq_n_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmovq_n_f32(1.0f32));
        check_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: vmovq_n_f32(1.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovq_n_f32(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovq_n_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vmovq_n_p16(1u16));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vmovq_n_p16(1u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovq_n_p16(rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovq_n_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vmovq_n_p8(1u8));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vmovq_n_p8(1u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovq_n_p8(rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovq_n_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmovq_n_s16(1i16));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vmovq_n_s16(1i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovq_n_s16(rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovq_n_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmovq_n_s32(1i32));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vmovq_n_s32(1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovq_n_s32(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovq_n_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmovq_n_s64(1i64));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vmovq_n_s64(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovq_n_s64(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovq_n_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vmovq_n_s8(1i8));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vmovq_n_s8(1i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovq_n_s8(rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovq_n_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmovq_n_u16(1u16));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vmovq_n_u16(1u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovq_n_u16(rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovq_n_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmovq_n_u32(1u32));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vmovq_n_u32(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovq_n_u32(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovq_n_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmovq_n_u64(1u64));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vmovq_n_u64(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovq_n_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovq_n_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vmovq_n_u8(1u8));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vmovq_n_u8(1u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovq_n_u8(rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovl_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmovl_s16(create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vmovl_s16(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovl_s16(create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovl_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmovl_s32(create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vmovl_s32(create_int32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovl_s32(create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovl_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmovl_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vmovl_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovl_s8(create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovl_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmovl_u16(create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vmovl_u16(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovl_u16(create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovl_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmovl_u32(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vmovl_u32(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovl_u32(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovl_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmovl_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vmovl_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovl_u8(create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovn_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vmovn_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vmovn_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovn_s16(create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovn_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vmovn_s32(create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vmovn_s32(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovn_s32(create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovn_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vmovn_s64(create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vmovn_s64(create_int64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovn_s64(create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovn_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vmovn_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: vmovn_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovn_u16(create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovn_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vmovn_u32(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vmovn_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovn_u32(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmovn_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vmovn_u64(create_uint64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vmovn_u64(create_uint64x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmovn_u64(create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmul_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vmul_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[3.0, 8.0]).map_err(|e| format!("{e} | call: vmul_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmul_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmulq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmulq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[5.0, 12.0, 21.0, 32.0]).map_err(|e| format!("{e} | call: vmulq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmulq_f32(create_random_float32x4_t(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmul_lane_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vmul_lane_f32::<0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[3.0, 6.0]).map_err(|e| format!("{e} | call: vmul_lane_f32::<0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmul_lane_f32::<0>(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmul_laneq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vmul_laneq_f32::<0>(create_float32x2_t_from([1.0, 2.0]), create_float32x4_t_from([3.0, 4.0, 5.0, 6.0])));
        check_array_equality(&result, &[3.0, 6.0]).map_err(|e| format!("{e} | call: vmul_laneq_f32::<0>(create_float32x2_t_from([1.0, 2.0]), create_float32x4_t_from([3.0, 4.0, 5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmul_laneq_f32::<0>(create_random_float32x2_t(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmulq_lane_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmulq_lane_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x2_t_from([5.0, 6.0])));
        check_array_equality(&result, &[5.0, 10.0, 15.0, 20.0]).map_err(|e| format!("{e} | call: vmulq_lane_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x2_t_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmulq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmulq_laneq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmulq_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[5.0, 10.0, 15.0, 20.0]).map_err(|e| format!("{e} | call: vmulq_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmulq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmul_lane_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vmul_lane_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 10, 15, 20]).map_err(|e| format!("{e} | call: vmul_lane_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmul_lane_s16::<0>(create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmulq_lane_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmulq_lane_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 18, 27, 36, 45, 54, 63, 72]).map_err(|e| format!("{e} | call: vmulq_lane_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmulq_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmul_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vmul_lane_s32::<0>(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 6]).map_err(|e| format!("{e} | call: vmul_lane_s32::<0>(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmul_lane_s32::<0>(create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmulq_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmulq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[5, 10, 15, 20]).map_err(|e| format!("{e} | call: vmulq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmulq_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmul_lane_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vmul_lane_u16::<0>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 10, 15, 20]).map_err(|e| format!("{e} | call: vmul_lane_u16::<0>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmul_lane_u16::<0>(create_random_uint16x4_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmulq_lane_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmulq_lane_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 18, 27, 36, 45, 54, 63, 72]).map_err(|e| format!("{e} | call: vmulq_lane_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmulq_lane_u16::<0>(create_random_uint16x8_t(), create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmul_lane_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vmul_lane_u32::<0>(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 6]).map_err(|e| format!("{e} | call: vmul_lane_u32::<0>(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmul_lane_u32::<0>(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmulq_lane_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmulq_lane_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[5, 10, 15, 20]).map_err(|e| format!("{e} | call: vmulq_lane_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmulq_lane_u32::<0>(create_random_uint32x4_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmul_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vmul_laneq_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[5, 10, 15, 20]).map_err(|e| format!("{e} | call: vmul_laneq_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmul_laneq_s16::<0>(create_random_int16x4_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmulq_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmulq_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 18, 27, 36, 45, 54, 63, 72]).map_err(|e| format!("{e} | call: vmulq_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmulq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmul_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vmul_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[3, 6]).map_err(|e| format!("{e} | call: vmul_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmul_laneq_s32::<0>(create_random_int32x2_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmulq_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmulq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 10, 15, 20]).map_err(|e| format!("{e} | call: vmulq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmulq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}
