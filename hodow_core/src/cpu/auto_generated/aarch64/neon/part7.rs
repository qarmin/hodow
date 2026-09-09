use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_neon_vcvtm_u32_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtm_u32_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vcvtm_u32_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtm_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtm_u32_f32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtm_u32_f32(create_float32x2_t_from([0.0f32, -1.0f32])));
        check_array_equality(&result, &[0u32; 2]).map_err(|e| format!("{e} | call: vcvtm_u32_f32(create_float32x2_t_from([0.0f32, -1.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtm_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtm_u32_f32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtm_u32_f32(create_float32x2_t_from([100.0f32, 200.0f32])));
        check_array_equality(&result, &[100, 200]).map_err(|e| format!("{e} | call: vcvtm_u32_f32(create_float32x2_t_from([100.0f32, 200.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtm_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtm_u32_f32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtm_u32_f32(create_float32x2_t_from([f32::MIN, f32::MIN])));
        check_array_equality(&result, &[0u32; 2]).map_err(|e| format!("{e} | call: vcvtm_u32_f32(create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtm_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtm_u32_f32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtm_u32_f32(create_float32x2_t_from([f32::MAX, f32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| format!("{e} | call: vcvtm_u32_f32(create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtm_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtm_u32_f32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtm_u32_f32(create_float32x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0u32; 2]).map_err(|e| format!("{e} | call: vcvtm_u32_f32(create_float32x2_t_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtm_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtm_u32_f32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtm_u32_f32(create_float32x2_t_from([f32::NAN, f32::NAN])));
        check_array_equality(&result, &[0u32; 2]).map_err(|e| format!("{e} | call: vcvtm_u32_f32(create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtm_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtm_u32_f32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtm_u32_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY])));
        check_array_equality(&result, &[4294967295, 0]).map_err(|e| format!("{e} | call: vcvtm_u32_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtm_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtmq_u32_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtmq_u32_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vcvtmq_u32_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtmq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtmq_u32_f32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtmq_u32_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_array_equality(&result, &[0, 0, 2, 0]).map_err(|e| format!("{e} | call: vcvtmq_u32_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtmq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtmq_u32_f32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtmq_u32_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_array_equality(&result, &[100, 200, 300, 400]).map_err(|e| format!("{e} | call: vcvtmq_u32_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtmq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtmq_u32_f32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtmq_u32_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[0u32; 4]).map_err(|e| format!("{e} | call: vcvtmq_u32_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtmq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtmq_u32_f32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtmq_u32_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| format!("{e} | call: vcvtmq_u32_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtmq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtmq_u32_f32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtmq_u32_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0u32; 4]).map_err(|e| format!("{e} | call: vcvtmq_u32_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtmq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtmq_u32_f32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtmq_u32_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[0u32; 4]).map_err(|e| format!("{e} | call: vcvtmq_u32_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtmq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtmq_u32_f32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtmq_u32_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[4294967295, 0, 0, 0]).map_err(|e| format!("{e} | call: vcvtmq_u32_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtmq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtm_u64_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtm_u64_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vcvtm_u64_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtm_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtm_u64_f64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtm_u64_f64(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vcvtm_u64_f64(create_float64x1_t_from([0.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtm_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtm_u64_f64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtm_u64_f64(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[100]).map_err(|e| format!("{e} | call: vcvtm_u64_f64(create_float64x1_t_from([100.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtm_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtm_u64_f64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtm_u64_f64(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vcvtm_u64_f64(create_float64x1_t_from([f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtm_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtm_u64_f64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtm_u64_f64(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: vcvtm_u64_f64(create_float64x1_t_from([f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtm_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtm_u64_f64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtm_u64_f64(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vcvtm_u64_f64(create_float64x1_t_from([0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtm_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtm_u64_f64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtm_u64_f64(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vcvtm_u64_f64(create_float64x1_t_from([f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtm_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtm_u64_f64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtm_u64_f64(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: vcvtm_u64_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtm_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtmq_u64_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtmq_u64_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vcvtmq_u64_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtmq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtmq_u64_f64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtmq_u64_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vcvtmq_u64_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtmq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtmq_u64_f64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtmq_u64_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_array_equality(&result, &[100, 200]).map_err(|e| format!("{e} | call: vcvtmq_u64_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtmq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtmq_u64_f64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtmq_u64_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vcvtmq_u64_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtmq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtmq_u64_f64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtmq_u64_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| format!("{e} | call: vcvtmq_u64_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtmq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtmq_u64_f64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtmq_u64_f64(create_float64x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vcvtmq_u64_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtmq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtmq_u64_f64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtmq_u64_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vcvtmq_u64_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtmq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtmq_u64_f64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtmq_u64_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_array_equality(&result, &[18446744073709551615, 0]).map_err(|e| format!("{e} | call: vcvtmq_u64_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtmq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtms_s32_f32() -> Result<(), String> {
    unsafe {
        let result = vcvtms_s32_f32(1.0f32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vcvtms_s32_f32(1.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtms_s32_f32(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtmd_s64_f64() -> Result<(), String> {
    unsafe {
        let result = vcvtmd_s64_f64(1.0f64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vcvtmd_s64_f64(1.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtmd_s64_f64(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtms_u32_f32() -> Result<(), String> {
    unsafe {
        let result = vcvtms_u32_f32(1.0f32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vcvtms_u32_f32(1.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtms_u32_f32(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtmd_u64_f64() -> Result<(), String> {
    unsafe {
        let result = vcvtmd_u64_f64(1.0f64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vcvtmd_u64_f64(1.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtmd_u64_f64(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_s32_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcvtn_s32_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vcvtn_s32_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_s32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_s32_f32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcvtn_s32_f32(create_float32x2_t_from([0.0f32, -1.0f32])));
        check_array_equality(&result, &[0, -1]).map_err(|e| format!("{e} | call: vcvtn_s32_f32(create_float32x2_t_from([0.0f32, -1.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_s32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_s32_f32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcvtn_s32_f32(create_float32x2_t_from([100.0f32, 200.0f32])));
        check_array_equality(&result, &[100, 200]).map_err(|e| format!("{e} | call: vcvtn_s32_f32(create_float32x2_t_from([100.0f32, 200.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_s32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_s32_f32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcvtn_s32_f32(create_float32x2_t_from([f32::MIN, f32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648]).map_err(|e| format!("{e} | call: vcvtn_s32_f32(create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_s32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_s32_f32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcvtn_s32_f32(create_float32x2_t_from([f32::MAX, f32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647]).map_err(|e| format!("{e} | call: vcvtn_s32_f32(create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_s32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_s32_f32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcvtn_s32_f32(create_float32x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0i32; 2]).map_err(|e| format!("{e} | call: vcvtn_s32_f32(create_float32x2_t_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_s32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_s32_f32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcvtn_s32_f32(create_float32x2_t_from([f32::NAN, f32::NAN])));
        check_array_equality(&result, &[0i32; 2]).map_err(|e| format!("{e} | call: vcvtn_s32_f32(create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_s32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_s32_f32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcvtn_s32_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY])));
        check_array_equality(&result, &[2147483647, -2147483648]).map_err(|e| format!("{e} | call: vcvtn_s32_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_s32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_s32_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtnq_s32_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vcvtnq_s32_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_s32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_s32_f32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtnq_s32_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_array_equality(&result, &[0, -1, 2, -3]).map_err(|e| format!("{e} | call: vcvtnq_s32_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_s32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_s32_f32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtnq_s32_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_array_equality(&result, &[100, 200, 300, 400]).map_err(|e| format!("{e} | call: vcvtnq_s32_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_s32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_s32_f32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtnq_s32_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| format!("{e} | call: vcvtnq_s32_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_s32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_s32_f32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtnq_s32_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| format!("{e} | call: vcvtnq_s32_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_s32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_s32_f32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtnq_s32_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0i32; 4]).map_err(|e| format!("{e} | call: vcvtnq_s32_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_s32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_s32_f32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtnq_s32_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[0i32; 4]).map_err(|e| format!("{e} | call: vcvtnq_s32_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_s32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_s32_f32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtnq_s32_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[2147483647, -2147483648, 0, 0]).map_err(|e| format!("{e} | call: vcvtnq_s32_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_s32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_s64_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvtn_s64_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vcvtn_s64_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_s64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_s64_f64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvtn_s64_f64(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: vcvtn_s64_f64(create_float64x1_t_from([0.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_s64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_s64_f64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvtn_s64_f64(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[100]).map_err(|e| format!("{e} | call: vcvtn_s64_f64(create_float64x1_t_from([100.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_s64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_s64_f64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvtn_s64_f64(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[-9223372036854775808]).map_err(|e| format!("{e} | call: vcvtn_s64_f64(create_float64x1_t_from([f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_s64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_s64_f64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvtn_s64_f64(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[9223372036854775807]).map_err(|e| format!("{e} | call: vcvtn_s64_f64(create_float64x1_t_from([f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_s64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_s64_f64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvtn_s64_f64(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: vcvtn_s64_f64(create_float64x1_t_from([0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_s64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_s64_f64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvtn_s64_f64(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: vcvtn_s64_f64(create_float64x1_t_from([f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_s64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_s64_f64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvtn_s64_f64(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[9223372036854775807]).map_err(|e| format!("{e} | call: vcvtn_s64_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_s64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_s64_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vcvtnq_s64_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vcvtnq_s64_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_s64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_s64_f64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vcvtnq_s64_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_array_equality(&result, &[0, -1]).map_err(|e| format!("{e} | call: vcvtnq_s64_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_s64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_s64_f64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vcvtnq_s64_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_array_equality(&result, &[100, 200]).map_err(|e| format!("{e} | call: vcvtnq_s64_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_s64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_s64_f64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vcvtnq_s64_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808]).map_err(|e| format!("{e} | call: vcvtnq_s64_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_s64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_s64_f64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vcvtnq_s64_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807]).map_err(|e| format!("{e} | call: vcvtnq_s64_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_s64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_s64_f64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vcvtnq_s64_f64(create_float64x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0i64; 2]).map_err(|e| format!("{e} | call: vcvtnq_s64_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_s64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_s64_f64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vcvtnq_s64_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_array_equality(&result, &[0i64; 2]).map_err(|e| format!("{e} | call: vcvtnq_s64_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_s64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_s64_f64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vcvtnq_s64_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_array_equality(&result, &[9223372036854775807, -9223372036854775808]).map_err(|e| format!("{e} | call: vcvtnq_s64_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_s64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_u32_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtn_u32_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vcvtn_u32_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_u32_f32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtn_u32_f32(create_float32x2_t_from([0.0f32, -1.0f32])));
        check_array_equality(&result, &[0u32; 2]).map_err(|e| format!("{e} | call: vcvtn_u32_f32(create_float32x2_t_from([0.0f32, -1.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_u32_f32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtn_u32_f32(create_float32x2_t_from([100.0f32, 200.0f32])));
        check_array_equality(&result, &[100, 200]).map_err(|e| format!("{e} | call: vcvtn_u32_f32(create_float32x2_t_from([100.0f32, 200.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_u32_f32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtn_u32_f32(create_float32x2_t_from([f32::MIN, f32::MIN])));
        check_array_equality(&result, &[0u32; 2]).map_err(|e| format!("{e} | call: vcvtn_u32_f32(create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_u32_f32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtn_u32_f32(create_float32x2_t_from([f32::MAX, f32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| format!("{e} | call: vcvtn_u32_f32(create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_u32_f32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtn_u32_f32(create_float32x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0u32; 2]).map_err(|e| format!("{e} | call: vcvtn_u32_f32(create_float32x2_t_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_u32_f32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtn_u32_f32(create_float32x2_t_from([f32::NAN, f32::NAN])));
        check_array_equality(&result, &[0u32; 2]).map_err(|e| format!("{e} | call: vcvtn_u32_f32(create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_u32_f32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtn_u32_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY])));
        check_array_equality(&result, &[4294967295, 0]).map_err(|e| format!("{e} | call: vcvtn_u32_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_u32_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtnq_u32_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vcvtnq_u32_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_u32_f32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtnq_u32_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_array_equality(&result, &[0, 0, 2, 0]).map_err(|e| format!("{e} | call: vcvtnq_u32_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_u32_f32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtnq_u32_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_array_equality(&result, &[100, 200, 300, 400]).map_err(|e| format!("{e} | call: vcvtnq_u32_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_u32_f32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtnq_u32_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[0u32; 4]).map_err(|e| format!("{e} | call: vcvtnq_u32_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_u32_f32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtnq_u32_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| format!("{e} | call: vcvtnq_u32_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_u32_f32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtnq_u32_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0u32; 4]).map_err(|e| format!("{e} | call: vcvtnq_u32_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_u32_f32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtnq_u32_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[0u32; 4]).map_err(|e| format!("{e} | call: vcvtnq_u32_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_u32_f32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtnq_u32_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[4294967295, 0, 0, 0]).map_err(|e| format!("{e} | call: vcvtnq_u32_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_u64_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtn_u64_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vcvtn_u64_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_u64_f64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtn_u64_f64(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vcvtn_u64_f64(create_float64x1_t_from([0.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_u64_f64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtn_u64_f64(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[100]).map_err(|e| format!("{e} | call: vcvtn_u64_f64(create_float64x1_t_from([100.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_u64_f64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtn_u64_f64(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vcvtn_u64_f64(create_float64x1_t_from([f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_u64_f64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtn_u64_f64(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: vcvtn_u64_f64(create_float64x1_t_from([f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_u64_f64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtn_u64_f64(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vcvtn_u64_f64(create_float64x1_t_from([0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_u64_f64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtn_u64_f64(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vcvtn_u64_f64(create_float64x1_t_from([f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtn_u64_f64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtn_u64_f64(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: vcvtn_u64_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtn_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_u64_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtnq_u64_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vcvtnq_u64_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_u64_f64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtnq_u64_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vcvtnq_u64_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_u64_f64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtnq_u64_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_array_equality(&result, &[100, 200]).map_err(|e| format!("{e} | call: vcvtnq_u64_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_u64_f64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtnq_u64_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vcvtnq_u64_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_u64_f64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtnq_u64_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| format!("{e} | call: vcvtnq_u64_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_u64_f64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtnq_u64_f64(create_float64x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vcvtnq_u64_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_u64_f64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtnq_u64_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vcvtnq_u64_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnq_u64_f64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtnq_u64_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_array_equality(&result, &[18446744073709551615, 0]).map_err(|e| format!("{e} | call: vcvtnq_u64_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtns_s32_f32() -> Result<(), String> {
    unsafe {
        let result = vcvtns_s32_f32(1.0f32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vcvtns_s32_f32(1.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtns_s32_f32(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnd_s64_f64() -> Result<(), String> {
    unsafe {
        let result = vcvtnd_s64_f64(1.0f64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vcvtnd_s64_f64(1.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnd_s64_f64(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtns_u32_f32() -> Result<(), String> {
    unsafe {
        let result = vcvtns_u32_f32(1.0f32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vcvtns_u32_f32(1.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtns_u32_f32(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtnd_u64_f64() -> Result<(), String> {
    unsafe {
        let result = vcvtnd_u64_f64(1.0f64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vcvtnd_u64_f64(1.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtnd_u64_f64(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_s32_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcvtp_s32_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vcvtp_s32_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_s32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_s32_f32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcvtp_s32_f32(create_float32x2_t_from([0.0f32, -1.0f32])));
        check_array_equality(&result, &[0, -1]).map_err(|e| format!("{e} | call: vcvtp_s32_f32(create_float32x2_t_from([0.0f32, -1.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_s32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_s32_f32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcvtp_s32_f32(create_float32x2_t_from([100.0f32, 200.0f32])));
        check_array_equality(&result, &[100, 200]).map_err(|e| format!("{e} | call: vcvtp_s32_f32(create_float32x2_t_from([100.0f32, 200.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_s32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_s32_f32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcvtp_s32_f32(create_float32x2_t_from([f32::MIN, f32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648]).map_err(|e| format!("{e} | call: vcvtp_s32_f32(create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_s32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_s32_f32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcvtp_s32_f32(create_float32x2_t_from([f32::MAX, f32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647]).map_err(|e| format!("{e} | call: vcvtp_s32_f32(create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_s32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_s32_f32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcvtp_s32_f32(create_float32x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0i32; 2]).map_err(|e| format!("{e} | call: vcvtp_s32_f32(create_float32x2_t_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_s32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_s32_f32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcvtp_s32_f32(create_float32x2_t_from([f32::NAN, f32::NAN])));
        check_array_equality(&result, &[0i32; 2]).map_err(|e| format!("{e} | call: vcvtp_s32_f32(create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_s32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_s32_f32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcvtp_s32_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY])));
        check_array_equality(&result, &[2147483647, -2147483648]).map_err(|e| format!("{e} | call: vcvtp_s32_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_s32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_s32_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtpq_s32_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vcvtpq_s32_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_s32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_s32_f32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtpq_s32_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_array_equality(&result, &[0, -1, 2, -3]).map_err(|e| format!("{e} | call: vcvtpq_s32_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_s32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_s32_f32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtpq_s32_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_array_equality(&result, &[100, 200, 300, 400]).map_err(|e| format!("{e} | call: vcvtpq_s32_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_s32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_s32_f32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtpq_s32_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| format!("{e} | call: vcvtpq_s32_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_s32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_s32_f32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtpq_s32_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| format!("{e} | call: vcvtpq_s32_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_s32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_s32_f32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtpq_s32_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0i32; 4]).map_err(|e| format!("{e} | call: vcvtpq_s32_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_s32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_s32_f32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtpq_s32_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[0i32; 4]).map_err(|e| format!("{e} | call: vcvtpq_s32_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_s32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_s32_f32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtpq_s32_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[2147483647, -2147483648, 0, 1]).map_err(|e| format!("{e} | call: vcvtpq_s32_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_s32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_s64_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvtp_s64_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vcvtp_s64_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_s64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_s64_f64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvtp_s64_f64(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: vcvtp_s64_f64(create_float64x1_t_from([0.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_s64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_s64_f64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvtp_s64_f64(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[100]).map_err(|e| format!("{e} | call: vcvtp_s64_f64(create_float64x1_t_from([100.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_s64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_s64_f64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvtp_s64_f64(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[-9223372036854775808]).map_err(|e| format!("{e} | call: vcvtp_s64_f64(create_float64x1_t_from([f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_s64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_s64_f64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvtp_s64_f64(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[9223372036854775807]).map_err(|e| format!("{e} | call: vcvtp_s64_f64(create_float64x1_t_from([f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_s64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_s64_f64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvtp_s64_f64(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: vcvtp_s64_f64(create_float64x1_t_from([0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_s64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_s64_f64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvtp_s64_f64(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: vcvtp_s64_f64(create_float64x1_t_from([f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_s64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_s64_f64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvtp_s64_f64(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[9223372036854775807]).map_err(|e| format!("{e} | call: vcvtp_s64_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_s64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_s64_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vcvtpq_s64_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vcvtpq_s64_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_s64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_s64_f64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vcvtpq_s64_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_array_equality(&result, &[0, -1]).map_err(|e| format!("{e} | call: vcvtpq_s64_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_s64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_s64_f64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vcvtpq_s64_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_array_equality(&result, &[100, 200]).map_err(|e| format!("{e} | call: vcvtpq_s64_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_s64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_s64_f64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vcvtpq_s64_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808]).map_err(|e| format!("{e} | call: vcvtpq_s64_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_s64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_s64_f64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vcvtpq_s64_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807]).map_err(|e| format!("{e} | call: vcvtpq_s64_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_s64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_s64_f64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vcvtpq_s64_f64(create_float64x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0i64; 2]).map_err(|e| format!("{e} | call: vcvtpq_s64_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_s64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_s64_f64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vcvtpq_s64_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_array_equality(&result, &[0i64; 2]).map_err(|e| format!("{e} | call: vcvtpq_s64_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_s64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_s64_f64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vcvtpq_s64_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_array_equality(&result, &[9223372036854775807, -9223372036854775808]).map_err(|e| format!("{e} | call: vcvtpq_s64_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_s64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_u32_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtp_u32_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vcvtp_u32_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_u32_f32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtp_u32_f32(create_float32x2_t_from([0.0f32, -1.0f32])));
        check_array_equality(&result, &[0u32; 2]).map_err(|e| format!("{e} | call: vcvtp_u32_f32(create_float32x2_t_from([0.0f32, -1.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_u32_f32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtp_u32_f32(create_float32x2_t_from([100.0f32, 200.0f32])));
        check_array_equality(&result, &[100, 200]).map_err(|e| format!("{e} | call: vcvtp_u32_f32(create_float32x2_t_from([100.0f32, 200.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_u32_f32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtp_u32_f32(create_float32x2_t_from([f32::MIN, f32::MIN])));
        check_array_equality(&result, &[0u32; 2]).map_err(|e| format!("{e} | call: vcvtp_u32_f32(create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_u32_f32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtp_u32_f32(create_float32x2_t_from([f32::MAX, f32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| format!("{e} | call: vcvtp_u32_f32(create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_u32_f32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtp_u32_f32(create_float32x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0u32; 2]).map_err(|e| format!("{e} | call: vcvtp_u32_f32(create_float32x2_t_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_u32_f32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtp_u32_f32(create_float32x2_t_from([f32::NAN, f32::NAN])));
        check_array_equality(&result, &[0u32; 2]).map_err(|e| format!("{e} | call: vcvtp_u32_f32(create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_u32_f32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcvtp_u32_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY])));
        check_array_equality(&result, &[4294967295, 0]).map_err(|e| format!("{e} | call: vcvtp_u32_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_u32_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_u32_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtpq_u32_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: vcvtpq_u32_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_u32_f32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtpq_u32_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_array_equality(&result, &[0, 0, 2, 0]).map_err(|e| format!("{e} | call: vcvtpq_u32_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_u32_f32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtpq_u32_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_array_equality(&result, &[100, 200, 300, 400]).map_err(|e| format!("{e} | call: vcvtpq_u32_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_u32_f32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtpq_u32_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[0u32; 4]).map_err(|e| format!("{e} | call: vcvtpq_u32_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_u32_f32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtpq_u32_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| format!("{e} | call: vcvtpq_u32_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_u32_f32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtpq_u32_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0u32; 4]).map_err(|e| format!("{e} | call: vcvtpq_u32_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_u32_f32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtpq_u32_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[0u32; 4]).map_err(|e| format!("{e} | call: vcvtpq_u32_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_u32_f32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtpq_u32_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[4294967295, 0, 0, 1]).map_err(|e| format!("{e} | call: vcvtpq_u32_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_u32_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_u64_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtp_u64_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vcvtp_u64_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_u64_f64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtp_u64_f64(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vcvtp_u64_f64(create_float64x1_t_from([0.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_u64_f64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtp_u64_f64(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[100]).map_err(|e| format!("{e} | call: vcvtp_u64_f64(create_float64x1_t_from([100.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_u64_f64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtp_u64_f64(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vcvtp_u64_f64(create_float64x1_t_from([f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_u64_f64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtp_u64_f64(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: vcvtp_u64_f64(create_float64x1_t_from([f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_u64_f64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtp_u64_f64(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vcvtp_u64_f64(create_float64x1_t_from([0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_u64_f64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtp_u64_f64(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vcvtp_u64_f64(create_float64x1_t_from([f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtp_u64_f64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvtp_u64_f64(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: vcvtp_u64_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtp_u64_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_u64_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtpq_u64_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vcvtpq_u64_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_u64_f64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtpq_u64_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vcvtpq_u64_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_u64_f64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtpq_u64_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_array_equality(&result, &[100, 200]).map_err(|e| format!("{e} | call: vcvtpq_u64_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_u64_f64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtpq_u64_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vcvtpq_u64_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_u64_f64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtpq_u64_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| format!("{e} | call: vcvtpq_u64_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_u64_f64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtpq_u64_f64(create_float64x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vcvtpq_u64_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_u64_f64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtpq_u64_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vcvtpq_u64_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpq_u64_f64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vcvtpq_u64_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_array_equality(&result, &[18446744073709551615, 0]).map_err(|e| format!("{e} | call: vcvtpq_u64_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpq_u64_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtps_s32_f32() -> Result<(), String> {
    unsafe {
        let result = vcvtps_s32_f32(1.0f32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vcvtps_s32_f32(1.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtps_s32_f32(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpd_s64_f64() -> Result<(), String> {
    unsafe {
        let result = vcvtpd_s64_f64(1.0f64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vcvtpd_s64_f64(1.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpd_s64_f64(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtps_u32_f32() -> Result<(), String> {
    unsafe {
        let result = vcvtps_u32_f32(1.0f32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vcvtps_u32_f32(1.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtps_u32_f32(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtpd_u64_f64() -> Result<(), String> {
    unsafe {
        let result = vcvtpd_u64_f64(1.0f64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vcvtpd_u64_f64(1.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtpd_u64_f64(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvts_f32_u32() -> Result<(), String> {
    unsafe {
        let _result = vcvts_f32_u32(1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvts_f32_u32(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtd_f64_u64() -> Result<(), String> {
    unsafe {
        let _result = vcvtd_f64_u64(1u64);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtd_f64_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvts_n_f32_s32() -> Result<(), String> {
    unsafe {
        let _result = vcvts_n_f32_s32::<1>(1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvts_n_f32_s32::<1>(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtd_n_f64_s64() -> Result<(), String> {
    unsafe {
        let _result = vcvtd_n_f64_s64::<1>(1i64);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtd_n_f64_s64::<1>(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvts_n_f32_u32() -> Result<(), String> {
    unsafe {
        let _result = vcvts_n_f32_u32::<1>(1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvts_n_f32_u32::<1>(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtd_n_f64_u64() -> Result<(), String> {
    unsafe {
        let _result = vcvtd_n_f64_u64::<1>(1u64);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtd_n_f64_u64::<1>(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvts_n_s32_f32() -> Result<(), String> {
    unsafe {
        let result = vcvts_n_s32_f32::<1>(1.0f32);
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: vcvts_n_s32_f32::<1>(1.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvts_n_s32_f32::<1>(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtd_n_s64_f64() -> Result<(), String> {
    unsafe {
        let result = vcvtd_n_s64_f64::<1>(1.0f64);
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: vcvtd_n_s64_f64::<1>(1.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtd_n_s64_f64::<1>(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvts_n_u32_f32() -> Result<(), String> {
    unsafe {
        let result = vcvts_n_u32_f32::<1>(1.0f32);
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: vcvts_n_u32_f32::<1>(1.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvts_n_u32_f32::<1>(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtd_n_u64_f64() -> Result<(), String> {
    unsafe {
        let result = vcvtd_n_u64_f64::<1>(1.0f64);
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: vcvtd_n_u64_f64::<1>(1.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtd_n_u64_f64::<1>(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvts_s32_f32() -> Result<(), String> {
    unsafe {
        let result = vcvts_s32_f32(1.0f32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vcvts_s32_f32(1.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvts_s32_f32(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtd_s64_f64() -> Result<(), String> {
    unsafe {
        let result = vcvtd_s64_f64(1.0f64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vcvtd_s64_f64(1.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtd_s64_f64(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvts_u32_f32() -> Result<(), String> {
    unsafe {
        let result = vcvts_u32_f32(1.0f32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vcvts_u32_f32(1.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvts_u32_f32(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtd_u64_f64() -> Result<(), String> {
    unsafe {
        let result = vcvtd_u64_f64(1.0f64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vcvtd_u64_f64(1.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtd_u64_f64(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtx_f32_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvtx_f32_f64(create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vcvtx_f32_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtx_f32_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtx_f32_f64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvtx_f32_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| format!("{e} | call: vcvtx_f32_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtx_f32_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtx_f32_f64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvtx_f32_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_float_array_equality(&result, &[100.0, 200.0]).map_err(|e| format!("{e} | call: vcvtx_f32_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtx_f32_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtx_f32_f64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvtx_f32_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: vcvtx_f32_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtx_f32_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtx_f32_f64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvtx_f32_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: vcvtx_f32_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtx_f32_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtx_f32_f64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvtx_f32_f64(create_float64x2_t_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0f32; 2]).map_err(|e| format!("{e} | call: vcvtx_f32_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtx_f32_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtx_f32_f64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvtx_f32_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: vcvtx_f32_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtx_f32_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtx_f32_f64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvtx_f32_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: vcvtx_f32_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtx_f32_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtx_high_f32_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtx_high_f32_f64(create_float32x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: vcvtx_high_f32_f64(create_float32x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtx_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtx_high_f32_f64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtx_high_f32_f64(create_float32x2_t_from([0.0f32, -1.0f32]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[0.0, -1.0, 1.0, 2.0]).map_err(|e| format!("{e} | call: vcvtx_high_f32_f64(create_float32x2_t_from([0.0f32, -1.0f32]), create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtx_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtx_high_f32_f64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtx_high_f32_f64(create_float32x2_t_from([100.0f32, 200.0f32]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[100.0, 200.0, 1.0, 2.0]).map_err(|e| format!("{e} | call: vcvtx_high_f32_f64(create_float32x2_t_from([100.0f32, 200.0f32]), create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtx_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtx_high_f32_f64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtx_high_f32_f64(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, 1.0, 2.0]).map_err(|e| format!("{e} | call: vcvtx_high_f32_f64(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtx_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtx_high_f32_f64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtx_high_f32_f64(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 1.0, 2.0]).map_err(|e| format!("{e} | call: vcvtx_high_f32_f64(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtx_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtx_high_f32_f64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtx_high_f32_f64(create_float32x2_t_from([0.0, 0.0]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 1.0, 2.0]).map_err(|e| format!("{e} | call: vcvtx_high_f32_f64(create_float32x2_t_from([0.0, 0.0]), create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtx_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtx_high_f32_f64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtx_high_f32_f64(create_float32x2_t_from([f32::NAN, f32::NAN]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, 1.0, 2.0]).map_err(|e| format!("{e} | call: vcvtx_high_f32_f64(create_float32x2_t_from([f32::NAN, f32::NAN]), create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtx_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtx_high_f32_f64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtx_high_f32_f64(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 1.0, 2.0]).map_err(|e| format!("{e} | call: vcvtx_high_f32_f64(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]), create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtx_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vcvtxd_f32_f64() -> Result<(), String> {
    unsafe {
        let _result = vcvtxd_f32_f64(1.0f64);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcvtxd_f32_f64(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdiv_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vdiv_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.33333334, 0.5]).map_err(|e| format!("{e} | call: vdiv_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdiv_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdiv_f32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vdiv_f32(create_float32x2_t_from([0.0f32, -1.0f32]), create_float32x2_t_from([10.0f32, 9.0f32])));
        check_float_array_equality(&result, &[0.0, -0.11111111]).map_err(|e| format!("{e} | call: vdiv_f32(create_float32x2_t_from([0.0f32, -1.0f32]), create_float32x2_t_from([10.0f32, 9.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdiv_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdiv_f32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vdiv_f32(create_float32x2_t_from([100.0f32, 200.0f32]), create_float32x2_t_from([110.0f32, 210.0f32])));
        check_float_array_equality(&result, &[0.90909094, 0.95238096]).map_err(|e| format!("{e} | call: vdiv_f32(create_float32x2_t_from([100.0f32, 200.0f32]), create_float32x2_t_from([110.0f32, 210.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdiv_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdiv_f32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vdiv_f32(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float32x2_t_from([f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[1.0, 1.0]).map_err(|e| format!("{e} | call: vdiv_f32(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdiv_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdiv_f32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vdiv_f32(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float32x2_t_from([f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.0, 1.0]).map_err(|e| format!("{e} | call: vdiv_f32(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdiv_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdiv_f32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vdiv_f32(create_float32x2_t_from([0.0, 0.0]), create_float32x2_t_from([0.0, 0.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: vdiv_f32(create_float32x2_t_from([0.0, 0.0]), create_float32x2_t_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdiv_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdiv_f32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vdiv_f32(create_float32x2_t_from([f32::NAN, f32::NAN]), create_float32x2_t_from([f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: vdiv_f32(create_float32x2_t_from([f32::NAN, f32::NAN]), create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdiv_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdiv_f32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vdiv_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]), create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: vdiv_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]), create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdiv_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdiv_f32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vdiv_f32(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float32x2_t_from([f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-1.0, -1.0]).map_err(|e| format!("{e} | call: vdiv_f32(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdiv_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vdiv_f32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vdiv_f32(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float32x2_t_from([f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.0, -1.0]).map_err(|e| format!("{e} | call: vdiv_f32(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vdiv_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}
