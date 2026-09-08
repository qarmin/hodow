#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_arm_shared_neon_vcreate_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcreate_u32(1u64));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: vcreate_u32(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcreate_u32(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vcreate_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcreate_u64(1u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vcreate_u64(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcreate_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vcreate_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcreate_p8(1u64));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vcreate_p8(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcreate_p8(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vcreate_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcreate_p16(1u64));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: vcreate_p16(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcreate_p16(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vcreate_p64() -> Result<(), String> {
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

pub(super) fn test_arm_shared_neon_vcvt_f32_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvt_f32_s32(create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vcvt_f32_s32(create_int32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvt_f32_s32(create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vcvtq_f32_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_f32_s32(create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: vcvtq_f32_s32(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtq_f32_s32(create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vcvt_f32_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvt_f32_u32(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vcvt_f32_u32(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvt_f32_u32(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vcvtq_f32_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_f32_u32(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: vcvtq_f32_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtq_f32_u32(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvt_n_f32_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvt_n_f32_s32::<1>(create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[0.5, 1.0]).map_err(|e| format!("{e} | call: vcvt_n_f32_s32::<1>(create_int32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvt_n_f32_s32::<1>(create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_s32::<1>(create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0.5, 1.0, 1.5, 2.0]).map_err(|e| format!("{e} | call: vcvtq_n_f32_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtq_n_f32_s32::<1>(create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvt_n_f32_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvt_n_f32_u32::<1>(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[0.5, 1.0]).map_err(|e| format!("{e} | call: vcvt_n_f32_u32::<1>(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvt_n_f32_u32::<1>(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0.5, 1.0, 1.5, 2.0]).map_err(|e| format!("{e} | call: vcvtq_n_f32_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtq_n_f32_u32::<1>(create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvt_n_s32_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcvt_n_s32_f32::<1>(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[2, 4]).map_err(|e| format!("{e} | call: vcvt_n_s32_f32::<1>(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvt_n_s32_f32::<1>(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_s32_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_n_s32_f32::<1>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[2, 4, 6, 8]).map_err(|e| format!("{e} | call: vcvtq_n_s32_f32::<1>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtq_n_s32_f32::<1>(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvt_n_u32_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvt_n_u32_f32::<1>(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[2, 4]).map_err(|e| format!("{e} | call: vcvt_n_u32_f32::<1>(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvt_n_u32_f32::<1>(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_u32_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_n_u32_f32::<1>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[2, 4, 6, 8]).map_err(|e| format!("{e} | call: vcvtq_n_u32_f32::<1>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtq_n_u32_f32::<1>(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vcvt_s32_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcvt_s32_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vcvt_s32_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvt_s32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vcvtq_s32_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_s32_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vcvtq_s32_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtq_s32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vcvt_u32_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvt_u32_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vcvt_u32_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvt_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vcvtq_u32_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_u32_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vcvtq_u32_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdot_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vdot_lane_s32::<0>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[231, 432]).map_err(|e| format!("{e} | call: vdot_lane_s32::<0>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdot_lane_s32::<0>(create_random_int32x2_t(), create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdotq_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vdotq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x8_t_from([21, 22, 23, 24, 25, 26, 27, 28])));
        check_array_equality(&result, &[591, 952, 1313, 1674]).map_err(|e| format!("{e} | call: vdotq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x8_t_from([21, 22, 23, 24, 25, 26, 27, 28]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdotq_lane_s32::<0>(create_random_int32x4_t(), create_random_int8x16_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdot_lane_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vdot_lane_u32::<0>(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[231, 432]).map_err(|e| format!("{e} | call: vdot_lane_u32::<0>(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdot_lane_u32::<0>(create_random_uint32x2_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdotq_lane_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vdotq_lane_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_uint8x8_t_from([21, 22, 23, 24, 25, 26, 27, 28])));
        check_array_equality(&result, &[591, 952, 1313, 1674]).map_err(|e| format!("{e} | call: vdotq_lane_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_uint8x8_t_from([21, 22, 23, 24, 25, 26, 27, 28]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdotq_lane_u32::<0>(create_random_uint32x4_t(), create_random_uint8x16_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdot_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vdot_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26])));
        check_array_equality(&result, &[231, 432]).map_err(|e| format!("{e} | call: vdot_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdot_laneq_s32::<0>(create_random_int32x2_t(), create_random_int8x8_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdotq_laneq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vdotq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[591, 952, 1313, 1674]).map_err(|e| format!("{e} | call: vdotq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdotq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdot_laneq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vdot_laneq_u32::<0>(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26])));
        check_array_equality(&result, &[231, 432]).map_err(|e| format!("{e} | call: vdot_laneq_u32::<0>(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdot_laneq_u32::<0>(create_random_uint32x2_t(), create_random_uint8x8_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdotq_laneq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vdotq_laneq_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_uint8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[591, 952, 1313, 1674]).map_err(|e| format!("{e} | call: vdotq_laneq_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_uint8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdotq_laneq_u32::<0>(create_random_uint32x4_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdot_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vdot_s32(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[231, 568]).map_err(|e| format!("{e} | call: vdot_s32(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdot_s32(create_random_int32x2_t(), create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdotq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vdotq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[591, 1120, 1777, 2562]).map_err(|e| format!("{e} | call: vdotq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdotq_s32(create_random_int32x4_t(), create_random_int8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdot_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vdot_u32(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[231, 568]).map_err(|e| format!("{e} | call: vdot_u32(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdot_u32(create_random_uint32x2_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdotq_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vdotq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_uint8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[591, 1120, 1777, 2562]).map_err(|e| format!("{e} | call: vdotq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_uint8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdotq_u32(create_random_uint32x4_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_lane_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vdup_lane_f32::<0>(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 1.0]).map_err(|e| format!("{e} | call: vdup_lane_f32::<0>(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_lane_f32::<0>(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vdup_lane_s32::<0>(create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vdup_lane_s32::<0>(create_int32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_lane_s32::<0>(create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_lane_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vdup_lane_u32::<0>(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vdup_lane_u32::<0>(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_lane_u32::<0>(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_lane_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vdupq_lane_f32::<0>(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: vdupq_lane_f32::<0>(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_lane_f32::<0>(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_lane_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vdupq_lane_s32::<0>(create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_lane_s32::<0>(create_int32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_lane_s32::<0>(create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_lane_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vdupq_lane_u32::<0>(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_lane_u32::<0>(create_uint32x2_t_from([1, 2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_lane_u32::<0>(create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_lane_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vdup_lane_p16::<0>(create_poly16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdup_lane_p16::<0>(create_poly16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_lane_p16::<0>(create_random_poly16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_lane_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vdup_lane_s16::<0>(create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdup_lane_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_lane_s16::<0>(create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_lane_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vdup_lane_u16::<0>(create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdup_lane_u16::<0>(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_lane_u16::<0>(create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_lane_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vdupq_lane_p16::<0>(create_poly16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_lane_p16::<0>(create_poly16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_lane_p16::<0>(create_random_poly16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_lane_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vdupq_lane_s16::<0>(create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_lane_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_lane_s16::<0>(create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_lane_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vdupq_lane_u16::<0>(create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_lane_u16::<0>(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_lane_u16::<0>(create_random_uint16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_lane_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vdup_lane_p8::<0>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdup_lane_p8::<0>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_lane_p8::<0>(create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_lane_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vdup_lane_s8::<0>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdup_lane_s8::<0>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_lane_s8::<0>(create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdup_lane_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vdup_lane_u8::<0>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdup_lane_u8::<0>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdup_lane_u8::<0>(create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_lane_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vdupq_lane_p8::<0>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_lane_p8::<0>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_lane_p8::<0>(create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vdupq_lane_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vdupq_lane_s8::<0>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vdupq_lane_s8::<0>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdupq_lane_s8::<0>(create_random_int8x8_t());
            }
        }
    }
    Ok(())
}
