#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_arm_shared_aes_vaesdq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vaesdq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[124, 124, 124, 124, 124, 124, 124, 124, 124, 124, 124, 8, 124, 124, 124, 124]).map_err(|e| format!("{e} | call: vaesdq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaesdq_u8(create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vaeseq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vaeseq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[202, 202, 202, 4, 202, 202, 202, 202, 202, 202, 202, 202, 202, 202, 202, 202]).map_err(|e| format!("{e} | call: vaeseq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaeseq_u8(create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vaesimcq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vaesimcq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[43, 60, 33, 50, 103, 80, 125, 70, 35, 52, 41, 58, 255, 136, 197, 174]).map_err(|e| format!("{e} | call: vaesimcq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaesimcq_u8(create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vaesmcq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vaesmcq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[3, 4, 9, 10, 15, 8, 21, 30, 11, 12, 1, 2, 23, 16, 45, 54]).map_err(|e| format!("{e} | call: vaesmcq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vaesmcq_u8(create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vcreate_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcreate_p64(1u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vcreate_p64(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcreate_p64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vld1_dup_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let result = unpack_poly64x1_t_to_u64_array(vld1_dup_p64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_dup_p64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_aes_vld1q_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let result = unpack_poly64x2_t_to_u64_array(vld1q_p64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vld1q_p64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vld1_lane_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let src = create_poly64x1_t_from([2]);
        let result = unpack_poly64x1_t_to_u64_array(vld1_lane_p64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_lane_p64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vld1q_lane_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let src = create_poly64x2_t_from([2, 3]);
        let result = unpack_poly64x2_t_to_u64_array(vld1q_lane_p64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3]).map_err(|e| format!("{e} | call: vld1q_lane_p64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_aes_vld1_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let result = unpack_poly64x1_t_to_u64_array(vld1_p64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vld1_p64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vld1q_dup_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let result = unpack_poly64x2_t_to_u64_array(vld1q_dup_p64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1q_dup_p64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vreinterpretq_s8_p128() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vreinterpretq_s8_p128(1u128));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpretq_s8_p128(1u128)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_s8_p128(rand::random::<u128>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vreinterpretq_s16_p128() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vreinterpretq_s16_p128(1u128));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpretq_s16_p128(1u128)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_s16_p128(rand::random::<u128>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vreinterpretq_s32_p128() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vreinterpretq_s32_p128(1u128));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpretq_s32_p128(1u128)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_s32_p128(rand::random::<u128>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vreinterpretq_s64_p128() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_p128(1u128));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: vreinterpretq_s64_p128(1u128)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_s64_p128(rand::random::<u128>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vreinterpretq_u8_p128() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vreinterpretq_u8_p128(1u128));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpretq_u8_p128(1u128)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_u8_p128(rand::random::<u128>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vreinterpretq_u16_p128() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vreinterpretq_u16_p128(1u128));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpretq_u16_p128(1u128)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_u16_p128(rand::random::<u128>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vreinterpretq_u32_p128() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vreinterpretq_u32_p128(1u128));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpretq_u32_p128(1u128)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_u32_p128(rand::random::<u128>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vreinterpretq_u64_p128() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_p128(1u128));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: vreinterpretq_u64_p128(1u128)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_u64_p128(rand::random::<u128>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vreinterpretq_p8_p128() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vreinterpretq_p8_p128(1u128));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpretq_p8_p128(1u128)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_p8_p128(rand::random::<u128>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vreinterpretq_p16_p128() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vreinterpretq_p16_p128(1u128));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vreinterpretq_p16_p128(1u128)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_p16_p128(rand::random::<u128>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vreinterpretq_p64_p128() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_p128(1u128));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: vreinterpretq_p64_p128(1u128)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_p64_p128(rand::random::<u128>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vreinterpretq_p128_p64() -> Result<(), String> {
    unsafe {
        let _result = vreinterpretq_p128_p64(create_poly64x2_t_from([1, 2]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vreinterpretq_p128_p64(create_random_poly64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vset_lane_p64() -> Result<(), String> {
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

pub(super) fn test_arm_shared_aes_vsetq_lane_p64() -> Result<(), String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vsetq_lane_p64::<0>(1u64, create_poly64x2_t_from([2, 3])));
        check_array_equality(&result, &[1, 3]).map_err(|e| format!("{e} | call: vsetq_lane_p64::<0>(1u64, create_poly64x2_t_from([2, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsetq_lane_p64::<0>(rand::random::<u64>(), create_random_poly64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vst1_lane_p64() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u64; 64]);
        let b = create_poly64x1_t_from([2]);
        vst1_lane_p64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_aes_vst1q_lane_p64() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u64; 64]);
        let b = create_poly64x2_t_from([2, 3]);
        vst1q_lane_p64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}
