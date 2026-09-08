use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_neon_vld1q_u64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let result = unpack_uint64x2_t_to_u64_array(vld1q_u64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1q_u64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1_p8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_poly8x8_t_to_u8_array(vld1_p8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_p8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1q_p8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_poly8x16_t_to_u8_array(vld1q_p8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_p8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1_p16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let result = unpack_poly16x4_t_to_u16_array(vld1_p16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_p16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1q_p16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let result = unpack_poly16x8_t_to_u16_array(vld1q_p16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_p16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let result = unpack_poly64x1_t_to_u64_array(vld1_p64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_p64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1q_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let result = unpack_poly64x2_t_to_u64_array(vld1q_p64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1q_p64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vldap1_lane_s64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x1_t_from([2]);
        let result = unpack_int64x1_t_to_i64_array(vldap1_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: vldap1_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vldap1q_lane_s64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x2_t_from([2, 3]);
        let result = unpack_int64x2_t_to_i64_array(vldap1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3]).map_err(|e| format!("{e} | call: vldap1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vldap1q_lane_f64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let src = create_float64x2_t_from([2.0, 3.0]);
        let result = unpack_float64x2_t_to_f64_array(vldap1q_lane_f64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[0.0f64; 2]).map_err(|e| format!("{e} | call: vldap1q_lane_f64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vldap1_lane_u64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x1_t_from([2]);
        let result = unpack_uint64x1_t_to_u64_array(vldap1_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vldap1_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vldap1q_lane_u64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x2_t_from([2, 3]);
        let result = unpack_uint64x2_t_to_u64_array(vldap1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vldap1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vldap1_lane_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let src = create_poly64x1_t_from([2]);
        let result = unpack_poly64x1_t_to_u64_array(vldap1_lane_p64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vldap1_lane_p64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vldap1q_lane_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let src = create_poly64x2_t_from([2, 3]);
        let result = unpack_poly64x2_t_to_u64_array(vldap1q_lane_p64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vldap1q_lane_p64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2_lane_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vluti2_lane_u8::<0>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0u8; 16]).map_err(|e| format!("{e} | call: vluti2_lane_u8::<0>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2_lane_u8::<0>(create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2q_lane_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vluti2q_lane_u8::<0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0u8; 16]).map_err(|e| format!("{e} | call: vluti2q_lane_u8::<0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2q_lane_u8::<0>(create_random_uint8x16_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2_lane_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vluti2_lane_u16::<0>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint8x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[0u16; 8]).map_err(|e| format!("{e} | call: vluti2_lane_u16::<0>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint8x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2_lane_u16::<0>(create_random_uint16x4_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2q_lane_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vluti2q_lane_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0u16; 8]).map_err(|e| format!("{e} | call: vluti2q_lane_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2q_lane_u16::<0>(create_random_uint16x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2_lane_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vluti2_lane_p8::<0>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0u8; 16]).map_err(|e| format!("{e} | call: vluti2_lane_p8::<0>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2_lane_p8::<0>(create_random_poly8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2q_lane_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vluti2q_lane_p8::<0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0u8; 16]).map_err(|e| format!("{e} | call: vluti2q_lane_p8::<0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2q_lane_p8::<0>(create_random_poly8x16_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2_lane_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vluti2_lane_p16::<0>(create_poly16x4_t_from([1, 2, 3, 4]), create_uint8x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[0u16; 8]).map_err(|e| format!("{e} | call: vluti2_lane_p16::<0>(create_poly16x4_t_from([1, 2, 3, 4]), create_uint8x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2_lane_p16::<0>(create_random_poly16x4_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2q_lane_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vluti2q_lane_p16::<0>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0u16; 8]).map_err(|e| format!("{e} | call: vluti2q_lane_p16::<0>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2q_lane_p16::<0>(create_random_poly16x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2_lane_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vluti2_lane_s8::<0>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0i8; 16]).map_err(|e| format!("{e} | call: vluti2_lane_s8::<0>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2_lane_s8::<0>(create_random_int8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2q_lane_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vluti2q_lane_s8::<0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0i8; 16]).map_err(|e| format!("{e} | call: vluti2q_lane_s8::<0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2q_lane_s8::<0>(create_random_int8x16_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2_lane_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vluti2_lane_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_uint8x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[0i16; 8]).map_err(|e| format!("{e} | call: vluti2_lane_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_uint8x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2_lane_s16::<0>(create_random_int16x4_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2q_lane_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vluti2q_lane_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0i16; 8]).map_err(|e| format!("{e} | call: vluti2q_lane_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2q_lane_s16::<0>(create_random_int16x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2_laneq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vluti2_laneq_u8::<0>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0u8; 16]).map_err(|e| format!("{e} | call: vluti2_laneq_u8::<0>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2_laneq_u8::<0>(create_random_uint8x8_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2q_laneq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vluti2q_laneq_u8::<0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[0u8; 16]).map_err(|e| format!("{e} | call: vluti2q_laneq_u8::<0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2q_laneq_u8::<0>(create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2_laneq_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vluti2_laneq_u16::<0>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[0u16; 8]).map_err(|e| format!("{e} | call: vluti2_laneq_u16::<0>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2_laneq_u16::<0>(create_random_uint16x4_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2q_laneq_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vluti2q_laneq_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0u16; 8]).map_err(|e| format!("{e} | call: vluti2q_laneq_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2q_laneq_u16::<0>(create_random_uint16x8_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2_laneq_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vluti2_laneq_p8::<0>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0u8; 16]).map_err(|e| format!("{e} | call: vluti2_laneq_p8::<0>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2_laneq_p8::<0>(create_random_poly8x8_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2q_laneq_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vluti2q_laneq_p8::<0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[0u8; 16]).map_err(|e| format!("{e} | call: vluti2q_laneq_p8::<0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2q_laneq_p8::<0>(create_random_poly8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2_laneq_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vluti2_laneq_p16::<0>(create_poly16x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[0u16; 8]).map_err(|e| format!("{e} | call: vluti2_laneq_p16::<0>(create_poly16x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2_laneq_p16::<0>(create_random_poly16x4_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2q_laneq_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vluti2q_laneq_p16::<0>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0u16; 8]).map_err(|e| format!("{e} | call: vluti2q_laneq_p16::<0>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2q_laneq_p16::<0>(create_random_poly16x8_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2_laneq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vluti2_laneq_s8::<0>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0i8; 16]).map_err(|e| format!("{e} | call: vluti2_laneq_s8::<0>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2_laneq_s8::<0>(create_random_int8x8_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2q_laneq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vluti2q_laneq_s8::<0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[0i8; 16]).map_err(|e| format!("{e} | call: vluti2q_laneq_s8::<0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2q_laneq_s8::<0>(create_random_int8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vluti2_laneq_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[0i16; 8]).map_err(|e| format!("{e} | call: vluti2_laneq_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2_laneq_s16::<0>(create_random_int16x4_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti2q_laneq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vluti2q_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0i16; 8]).map_err(|e| format!("{e} | call: vluti2q_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti2q_laneq_s16::<0>(create_random_int16x8_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti4q_lane_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vluti4q_lane_s8::<0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0i8; 16]).map_err(|e| format!("{e} | call: vluti4q_lane_s8::<0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti4q_lane_s8::<0>(create_random_int8x16_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti4q_lane_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vluti4q_lane_u8::<0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0u8; 16]).map_err(|e| format!("{e} | call: vluti4q_lane_u8::<0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti4q_lane_u8::<0>(create_random_uint8x16_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti4q_lane_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vluti4q_lane_p8::<0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0u8; 16]).map_err(|e| format!("{e} | call: vluti4q_lane_p8::<0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti4q_lane_p8::<0>(create_random_poly8x16_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti4q_laneq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vluti4q_laneq_s8::<0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[0i8; 16]).map_err(|e| format!("{e} | call: vluti4q_laneq_s8::<0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti4q_laneq_s8::<0>(create_random_int8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti4q_laneq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vluti4q_laneq_u8::<0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[0u8; 16]).map_err(|e| format!("{e} | call: vluti4q_laneq_u8::<0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti4q_laneq_u8::<0>(create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vluti4q_laneq_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vluti4q_laneq_p8::<0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[0u8; 16]).map_err(|e| format!("{e} | call: vluti4q_laneq_p8::<0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vluti4q_laneq_p8::<0>(create_random_poly8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmax_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vmax_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0])));
        check_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: vmax_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmax_f64(create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmaxq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vmaxq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[3.0, 4.0]).map_err(|e| format!("{e} | call: vmaxq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmaxq_f64(create_random_float64x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmaxnm_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vmaxnm_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0])));
        check_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: vmaxnm_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmaxnm_f64(create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmaxnmq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vmaxnmq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[3.0, 4.0]).map_err(|e| format!("{e} | call: vmaxnmq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmaxnmq_f64(create_random_float64x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmaxnmv_f32() -> Result<(), String> {
    unsafe {
        let _result = vmaxnmv_f32(create_float32x2_t_from([1.0, 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmaxnmv_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmaxnmvq_f64() -> Result<(), String> {
    unsafe {
        let _result = vmaxnmvq_f64(create_float64x2_t_from([1.0, 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmaxnmvq_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}
