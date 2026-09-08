use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vqrshrun_high_n_s64::<1>(create_uint32x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2, 2, 2]).map_err(|e| format!("{e} | call: vqrshrun_high_n_s64::<1>(create_uint32x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshrun_high_n_s64::<1>(create_random_uint32x2_t(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshrund_n_s64() -> Result<(), String> {
    unsafe {
        let result = vqrshrund_n_s64::<1>(1i64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrshrund_n_s64::<1>(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshrund_n_s64::<1>(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshrunh_n_s16() -> Result<(), String> {
    unsafe {
        let result = vqrshrunh_n_s16::<1>(1i16);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrshrunh_n_s16::<1>(1i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshrunh_n_s16::<1>(rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqrshruns_n_s32() -> Result<(), String> {
    unsafe {
        let result = vqrshruns_n_s32::<1>(1i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vqrshruns_n_s32::<1>(1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqrshruns_n_s32::<1>(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshlb_n_s8() -> Result<(), String> {
    unsafe {
        let result = vqshlb_n_s8::<1>(1i8);
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: vqshlb_n_s8::<1>(1i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshlb_n_s8::<1>(rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshld_n_s64() -> Result<(), String> {
    unsafe {
        let result = vqshld_n_s64::<1>(1i64);
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: vqshld_n_s64::<1>(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshld_n_s64::<1>(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshlh_n_s16() -> Result<(), String> {
    unsafe {
        let result = vqshlh_n_s16::<1>(1i16);
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: vqshlh_n_s16::<1>(1i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshlh_n_s16::<1>(rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshls_n_s32() -> Result<(), String> {
    unsafe {
        let result = vqshls_n_s32::<1>(1i32);
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: vqshls_n_s32::<1>(1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshls_n_s32::<1>(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshlb_n_u8() -> Result<(), String> {
    unsafe {
        let result = vqshlb_n_u8::<1>(1u8);
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: vqshlb_n_u8::<1>(1u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshlb_n_u8::<1>(rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshld_n_u64() -> Result<(), String> {
    unsafe {
        let result = vqshld_n_u64::<1>(1u64);
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: vqshld_n_u64::<1>(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshld_n_u64::<1>(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshlh_n_u16() -> Result<(), String> {
    unsafe {
        let result = vqshlh_n_u16::<1>(1u16);
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: vqshlh_n_u16::<1>(1u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshlh_n_u16::<1>(rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshls_n_u32() -> Result<(), String> {
    unsafe {
        let result = vqshls_n_u32::<1>(1u32);
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: vqshls_n_u32::<1>(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshls_n_u32::<1>(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshlb_s8() -> Result<(), String> {
    unsafe {
        let result = vqshlb_s8(1i8, 2i8);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqshlb_s8(1i8, 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshlb_s8(rand::random::<i8>(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshlh_s16() -> Result<(), String> {
    unsafe {
        let result = vqshlh_s16(1i16, 2i16);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqshlh_s16(1i16, 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshlh_s16(rand::random::<i16>(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshls_s32() -> Result<(), String> {
    unsafe {
        let result = vqshls_s32(1i32, 2i32);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqshls_s32(1i32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshls_s32(rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshlb_u8() -> Result<(), String> {
    unsafe {
        let result = vqshlb_u8(1u8, 2i8);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqshlb_u8(1u8, 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshlb_u8(rand::random::<u8>(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshlh_u16() -> Result<(), String> {
    unsafe {
        let result = vqshlh_u16(1u16, 2i16);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqshlh_u16(1u16, 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshlh_u16(rand::random::<u16>(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshls_u32() -> Result<(), String> {
    unsafe {
        let result = vqshls_u32(1u32, 2i32);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqshls_u32(1u32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshls_u32(rand::random::<u32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshld_s64() -> Result<(), String> {
    unsafe {
        let result = vqshld_s64(1i64, 2i64);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqshld_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshld_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshld_u64() -> Result<(), String> {
    unsafe {
        let result = vqshld_u64(1u64, 2i64);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vqshld_u64(1u64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshld_u64(rand::random::<u64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshlub_n_s8() -> Result<(), String> {
    unsafe {
        let result = vqshlub_n_s8::<1>(1i8);
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: vqshlub_n_s8::<1>(1i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshlub_n_s8::<1>(rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshlud_n_s64() -> Result<(), String> {
    unsafe {
        let result = vqshlud_n_s64::<1>(1i64);
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: vqshlud_n_s64::<1>(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshlud_n_s64::<1>(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshluh_n_s16() -> Result<(), String> {
    unsafe {
        let result = vqshluh_n_s16::<1>(1i16);
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: vqshluh_n_s16::<1>(1i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshluh_n_s16::<1>(rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshlus_n_s32() -> Result<(), String> {
    unsafe {
        let result = vqshlus_n_s32::<1>(1i32);
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: vqshlus_n_s32::<1>(1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshlus_n_s32::<1>(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshrn_high_n_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vqshrn_high_n_s16::<1>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 4, 5, 5, 6, 6, 7, 7, 8]).map_err(|e| format!("{e} | call: vqshrn_high_n_s16::<1>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshrn_high_n_s16::<1>(create_random_int8x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshrn_high_n_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqshrn_high_n_s32::<1>(create_int16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 2, 3, 3, 4]).map_err(|e| format!("{e} | call: vqshrn_high_n_s32::<1>(create_int16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshrn_high_n_s32::<1>(create_random_int16x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshrn_high_n_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqshrn_high_n_s64::<1>(create_int32x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2, 1, 2]).map_err(|e| format!("{e} | call: vqshrn_high_n_s64::<1>(create_int32x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshrn_high_n_s64::<1>(create_random_int32x2_t(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshrn_high_n_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vqshrn_high_n_u16::<1>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 4, 5, 5, 6, 6, 7, 7, 8]).map_err(|e| format!("{e} | call: vqshrn_high_n_u16::<1>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshrn_high_n_u16::<1>(create_random_uint8x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshrn_high_n_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vqshrn_high_n_u32::<1>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 2, 3, 3, 4]).map_err(|e| format!("{e} | call: vqshrn_high_n_u32::<1>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshrn_high_n_u32::<1>(create_random_uint16x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshrn_high_n_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vqshrn_high_n_u64::<1>(create_uint32x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2, 1, 2]).map_err(|e| format!("{e} | call: vqshrn_high_n_u64::<1>(create_uint32x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshrn_high_n_u64::<1>(create_random_uint32x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshrnd_n_s64() -> Result<(), String> {
    unsafe {
        let result = vqshrnd_n_s64::<1>(1i64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqshrnd_n_s64::<1>(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshrnd_n_s64::<1>(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshrnd_n_u64() -> Result<(), String> {
    unsafe {
        let result = vqshrnd_n_u64::<1>(1u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqshrnd_n_u64::<1>(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshrnd_n_u64::<1>(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshrnh_n_s16() -> Result<(), String> {
    unsafe {
        let result = vqshrnh_n_s16::<1>(1i16);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqshrnh_n_s16::<1>(1i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshrnh_n_s16::<1>(rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshrns_n_s32() -> Result<(), String> {
    unsafe {
        let result = vqshrns_n_s32::<1>(1i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqshrns_n_s32::<1>(1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshrns_n_s32::<1>(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshrnh_n_u16() -> Result<(), String> {
    unsafe {
        let result = vqshrnh_n_u16::<1>(1u16);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqshrnh_n_u16::<1>(1u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshrnh_n_u16::<1>(rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshrns_n_u32() -> Result<(), String> {
    unsafe {
        let result = vqshrns_n_u32::<1>(1u32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqshrns_n_u32::<1>(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshrns_n_u32::<1>(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshrun_high_n_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vqshrun_high_n_s16::<1>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 4, 5, 5, 6, 6, 7, 7, 8]).map_err(|e| format!("{e} | call: vqshrun_high_n_s16::<1>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshrun_high_n_s16::<1>(create_random_uint8x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshrun_high_n_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vqshrun_high_n_s32::<1>(create_uint16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 2, 3, 3, 4]).map_err(|e| format!("{e} | call: vqshrun_high_n_s32::<1>(create_uint16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshrun_high_n_s32::<1>(create_random_uint16x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshrun_high_n_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vqshrun_high_n_s64::<1>(create_uint32x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2, 1, 2]).map_err(|e| format!("{e} | call: vqshrun_high_n_s64::<1>(create_uint32x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshrun_high_n_s64::<1>(create_random_uint32x2_t(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshrund_n_s64() -> Result<(), String> {
    unsafe {
        let result = vqshrund_n_s64::<1>(1i64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqshrund_n_s64::<1>(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshrund_n_s64::<1>(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshrunh_n_s16() -> Result<(), String> {
    unsafe {
        let result = vqshrunh_n_s16::<1>(1i16);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqshrunh_n_s16::<1>(1i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshrunh_n_s16::<1>(rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqshruns_n_s32() -> Result<(), String> {
    unsafe {
        let result = vqshruns_n_s32::<1>(1i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqshruns_n_s32::<1>(1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqshruns_n_s32::<1>(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqsubb_s8() -> Result<(), String> {
    unsafe {
        let result = vqsubb_s8(1i8, 2i8);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vqsubb_s8(1i8, 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqsubb_s8(rand::random::<i8>(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqsubh_s16() -> Result<(), String> {
    unsafe {
        let result = vqsubh_s16(1i16, 2i16);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vqsubh_s16(1i16, 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqsubh_s16(rand::random::<i16>(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqsubb_u8() -> Result<(), String> {
    unsafe {
        let result = vqsubb_u8(1u8, 2u8);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqsubb_u8(1u8, 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqsubb_u8(rand::random::<u8>(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqsubh_u16() -> Result<(), String> {
    unsafe {
        let result = vqsubh_u16(1u16, 2u16);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqsubh_u16(1u16, 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqsubh_u16(rand::random::<u16>(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqsubs_s32() -> Result<(), String> {
    unsafe {
        let result = vqsubs_s32(1i32, 2i32);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vqsubs_s32(1i32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqsubs_s32(rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqsubd_s64() -> Result<(), String> {
    unsafe {
        let result = vqsubd_s64(1i64, 2i64);
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: vqsubd_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqsubd_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqsubs_u32() -> Result<(), String> {
    unsafe {
        let result = vqsubs_u32(1u32, 2u32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqsubs_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqsubs_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vqsubd_u64() -> Result<(), String> {
    unsafe {
        let result = vqsubd_u64(1u64, 2u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vqsubd_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vqsubd_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}
