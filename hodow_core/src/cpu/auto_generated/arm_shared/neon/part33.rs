#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vsri_n_u32::<1>(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vsri_n_u32::<1>(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u32::<1>(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vsri_n_u32::<1>(create_uint32x2_t_from([0, 4294967295]), create_uint32x2_t_from([10, 9])));
        check_array_equality(&result, &[5, 2147483652]).map_err(|e| format!("{e} | call: vsri_n_u32::<1>(create_uint32x2_t_from([0, 4294967295]), create_uint32x2_t_from([10, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u32::<1>(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vsri_n_u32::<1>(create_uint32x2_t_from([100, 200]), create_uint32x2_t_from([110, 210])));
        check_array_equality(&result, &[55, 105]).map_err(|e| format!("{e} | call: vsri_n_u32::<1>(create_uint32x2_t_from([100, 200]), create_uint32x2_t_from([110, 210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u32::<1>(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vsri_n_u32::<1>(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_uint32x2_t_from([u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: vsri_n_u32::<1>(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_uint32x2_t_from([u32::MIN, u32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u32::<1>(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vsri_n_u32::<1>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| format!("{e} | call: vsri_n_u32::<1>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u32::<1>(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vsri_n_u32::<1>(create_uint32x2_t_from([0, 0]), create_uint32x2_t_from([0, 0])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: vsri_n_u32::<1>(create_uint32x2_t_from([0, 0]), create_uint32x2_t_from([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u32::<1>(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vsri_n_u32::<1>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| format!("{e} | call: vsri_n_u32::<1>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u32::<1>(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vsri_n_u32::<1>(create_uint32x2_t_from([u32::MIN, u32::MAX]), create_uint32x2_t_from([u32::MIN, u32::MAX])));
        check_array_equality(&result, &[0, 4294967295]).map_err(|e| format!("{e} | call: vsri_n_u32::<1>(create_uint32x2_t_from([u32::MIN, u32::MAX]), create_uint32x2_t_from([u32::MIN, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u32::<1>(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vsri_n_u32::<1>(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647]).map_err(|e| format!("{e} | call: vsri_n_u32::<1>(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u32::<1>(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vsri_n_u32::<1>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MIN, u32::MIN])));
        check_array_equality(&result, &[2147483648, 2147483648]).map_err(|e| format!("{e} | call: vsri_n_u32::<1>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MIN, u32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u32::<1>(create_random_uint32x2_t(), create_random_uint32x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsriq_n_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[2, 3, 3, 4]).map_err(|e| format!("{e} | call: vsriq_n_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u32::<1>(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsriq_n_u32::<1>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint32x4_t_from([10, 9, 12, 7])));
        check_array_equality(&result, &[5, 2147483652, 6, 2147483651]).map_err(|e| format!("{e} | call: vsriq_n_u32::<1>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint32x4_t_from([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u32::<1>(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsriq_n_u32::<1>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint32x4_t_from([110, 210, 310, 410])));
        check_array_equality(&result, &[55, 105, 155, 205]).map_err(|e| format!("{e} | call: vsriq_n_u32::<1>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint32x4_t_from([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u32::<1>(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsriq_n_u32::<1>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: vsriq_n_u32::<1>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u32::<1>(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsriq_n_u32::<1>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| format!("{e} | call: vsriq_n_u32::<1>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u32::<1>(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsriq_n_u32::<1>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint32x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: vsriq_n_u32::<1>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint32x4_t_from([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u32::<1>(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsriq_n_u32::<1>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| format!("{e} | call: vsriq_n_u32::<1>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u32::<1>(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsriq_n_u32::<1>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0, 4294967295, 0, 4294967295]).map_err(|e| format!("{e} | call: vsriq_n_u32::<1>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u32::<1>(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsriq_n_u32::<1>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| format!("{e} | call: vsriq_n_u32::<1>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u32::<1>(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsriq_n_u32::<1>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[2147483648, 2147483648, 2147483648, 2147483648]).map_err(|e| format!("{e} | call: vsriq_n_u32::<1>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u32::<1>(create_random_uint32x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vsri_n_u64::<1>(create_uint64x1_t_from([1]), create_uint64x1_t_from([2])));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vsri_n_u64::<1>(create_uint64x1_t_from([1]), create_uint64x1_t_from([2]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u64::<1>(create_random_uint64x1_t(), create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vsri_n_u64::<1>(create_uint64x1_t_from([0]), create_uint64x1_t_from([10])));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: vsri_n_u64::<1>(create_uint64x1_t_from([0]), create_uint64x1_t_from([10]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u64::<1>(create_random_uint64x1_t(), create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vsri_n_u64::<1>(create_uint64x1_t_from([100]), create_uint64x1_t_from([110])));
        check_array_equality(&result, &[55]).map_err(|e| format!("{e} | call: vsri_n_u64::<1>(create_uint64x1_t_from([100]), create_uint64x1_t_from([110]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u64::<1>(create_random_uint64x1_t(), create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vsri_n_u64::<1>(create_uint64x1_t_from([u64::MIN]), create_uint64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0; 1]).map_err(|e| format!("{e} | call: vsri_n_u64::<1>(create_uint64x1_t_from([u64::MIN]), create_uint64x1_t_from([u64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u64::<1>(create_random_uint64x1_t(), create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vsri_n_u64::<1>(create_uint64x1_t_from([u64::MAX]), create_uint64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: vsri_n_u64::<1>(create_uint64x1_t_from([u64::MAX]), create_uint64x1_t_from([u64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u64::<1>(create_random_uint64x1_t(), create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vsri_n_u64::<1>(create_uint64x1_t_from([0]), create_uint64x1_t_from([0])));
        check_array_equality(&result, &[0; 1]).map_err(|e| format!("{e} | call: vsri_n_u64::<1>(create_uint64x1_t_from([0]), create_uint64x1_t_from([0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u64::<1>(create_random_uint64x1_t(), create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vsri_n_u64::<1>(create_uint64x1_t_from([u64::MAX]), create_uint64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: vsri_n_u64::<1>(create_uint64x1_t_from([u64::MAX]), create_uint64x1_t_from([u64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u64::<1>(create_random_uint64x1_t(), create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vsri_n_u64::<1>(create_uint64x1_t_from([u64::MIN]), create_uint64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0; 1]).map_err(|e| format!("{e} | call: vsri_n_u64::<1>(create_uint64x1_t_from([u64::MIN]), create_uint64x1_t_from([u64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u64::<1>(create_random_uint64x1_t(), create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u64_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vsri_n_u64::<1>(create_uint64x1_t_from([u64::MIN]), create_uint64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[9223372036854775807]).map_err(|e| format!("{e} | call: vsri_n_u64::<1>(create_uint64x1_t_from([u64::MIN]), create_uint64x1_t_from([u64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u64::<1>(create_random_uint64x1_t(), create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_u64_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vsri_n_u64::<1>(create_uint64x1_t_from([u64::MAX]), create_uint64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[9223372036854775808]).map_err(|e| format!("{e} | call: vsri_n_u64::<1>(create_uint64x1_t_from([u64::MAX]), create_uint64x1_t_from([u64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_u64::<1>(create_random_uint64x1_t(), create_random_uint64x1_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsriq_n_u64::<1>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: vsriq_n_u64::<1>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u64::<1>(create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsriq_n_u64::<1>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint64x2_t_from([10, 9])));
        check_array_equality(&result, &[5, 9223372036854775812]).map_err(|e| format!("{e} | call: vsriq_n_u64::<1>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint64x2_t_from([10, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u64::<1>(create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsriq_n_u64::<1>(create_uint64x2_t_from([100, 200]), create_uint64x2_t_from([110, 210])));
        check_array_equality(&result, &[55, 105]).map_err(|e| format!("{e} | call: vsriq_n_u64::<1>(create_uint64x2_t_from([100, 200]), create_uint64x2_t_from([110, 210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u64::<1>(create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsriq_n_u64::<1>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint64x2_t_from([u64::MIN, u64::MIN])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: vsriq_n_u64::<1>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint64x2_t_from([u64::MIN, u64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u64::<1>(create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsriq_n_u64::<1>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| format!("{e} | call: vsriq_n_u64::<1>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u64::<1>(create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsriq_n_u64::<1>(create_uint64x2_t_from([0, 0]), create_uint64x2_t_from([0, 0])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: vsriq_n_u64::<1>(create_uint64x2_t_from([0, 0]), create_uint64x2_t_from([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u64::<1>(create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsriq_n_u64::<1>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| format!("{e} | call: vsriq_n_u64::<1>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u64::<1>(create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsriq_n_u64::<1>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint64x2_t_from([u64::MIN, u64::MAX])));
        check_array_equality(&result, &[0, 18446744073709551615]).map_err(|e| format!("{e} | call: vsriq_n_u64::<1>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint64x2_t_from([u64::MIN, u64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u64::<1>(create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u64_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsriq_n_u64::<1>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807]).map_err(|e| format!("{e} | call: vsriq_n_u64::<1>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u64::<1>(create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_u64_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsriq_n_u64::<1>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint64x2_t_from([u64::MIN, u64::MIN])));
        check_array_equality(&result, &[9223372036854775808, 9223372036854775808]).map_err(|e| format!("{e} | call: vsriq_n_u64::<1>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint64x2_t_from([u64::MIN, u64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_u64::<1>(create_random_uint64x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vsri_n_p8::<1>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4, 5, 5, 6, 6, 7, 7, 8]).map_err(|e| format!("{e} | call: vsri_n_p8::<1>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p8::<1>(create_random_poly8x8_t(), create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p8_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vsri_n_p8::<1>(create_poly8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]), create_poly8x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[5, 132, 6, 131, 7, 130, 8, 129]).map_err(|e| format!("{e} | call: vsri_n_p8::<1>(create_poly8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]), create_poly8x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p8::<1>(create_random_poly8x8_t(), create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p8_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vsri_n_p8::<1>(create_poly8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]), create_poly8x8_t_from([110, 210, 54, 154, 254, 98, 198, 42])));
        check_array_equality(&result, &[55, 233, 27, 205, 255, 49, 227, 21]).map_err(|e| format!("{e} | call: vsri_n_p8::<1>(create_poly8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]), create_poly8x8_t_from([110, 210, 54, 154, 254, 98, 198, 42]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p8::<1>(create_random_poly8x8_t(), create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vsri_n_p8::<1>(create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: vsri_n_p8::<1>(create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p8::<1>(create_random_poly8x8_t(), create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vsri_n_p8::<1>(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| format!("{e} | call: vsri_n_p8::<1>(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p8::<1>(create_random_poly8x8_t(), create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vsri_n_p8::<1>(create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: vsri_n_p8::<1>(create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p8::<1>(create_random_poly8x8_t(), create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vsri_n_p8::<1>(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| format!("{e} | call: vsri_n_p8::<1>(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p8::<1>(create_random_poly8x8_t(), create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vsri_n_p8::<1>(create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0, 255, 0, 255, 0, 255, 0, 255]).map_err(|e| format!("{e} | call: vsri_n_p8::<1>(create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p8::<1>(create_random_poly8x8_t(), create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p8_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vsri_n_p8::<1>(create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127]).map_err(|e| format!("{e} | call: vsri_n_p8::<1>(create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p8::<1>(create_random_poly8x8_t(), create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p8_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vsri_n_p8::<1>(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[128, 128, 128, 128, 128, 128, 128, 128]).map_err(|e| format!("{e} | call: vsri_n_p8::<1>(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p8::<1>(create_random_poly8x8_t(), create_random_poly8x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p8() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsriq_n_p8::<1>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_poly8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 16]).map_err(|e| format!("{e} | call: vsriq_n_p8::<1>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_poly8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p8::<1>(create_random_poly8x16_t(), create_random_poly8x16_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p8_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsriq_n_p8::<1>(create_poly8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create_poly8x16_t_from([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[5, 132, 6, 131, 7, 130, 8, 129, 5, 132, 6, 131, 7, 130, 8, 129]).map_err(|e| format!("{e} | call: vsriq_n_p8::<1>(create_poly8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create_poly8x16_t_from([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p8::<1>(create_random_poly8x16_t(), create_random_poly8x16_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p8_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsriq_n_p8::<1>(create_poly8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]), create_poly8x16_t_from([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74])));
        check_array_equality(&result, &[55, 233, 27, 205, 255, 49, 227, 21, 199, 249, 43, 221, 15, 65, 243, 37]).map_err(|e| format!("{e} | call: vsriq_n_p8::<1>(create_poly8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]), create_poly8x16_t_from([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p8::<1>(create_random_poly8x16_t(), create_random_poly8x16_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsriq_n_p8::<1>(create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: vsriq_n_p8::<1>(create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p8::<1>(create_random_poly8x16_t(), create_random_poly8x16_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsriq_n_p8::<1>(create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| format!("{e} | call: vsriq_n_p8::<1>(create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p8::<1>(create_random_poly8x16_t(), create_random_poly8x16_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsriq_n_p8::<1>(create_poly8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create_poly8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: vsriq_n_p8::<1>(create_poly8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create_poly8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p8::<1>(create_random_poly8x16_t(), create_random_poly8x16_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsriq_n_p8::<1>(create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| format!("{e} | call: vsriq_n_p8::<1>(create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p8::<1>(create_random_poly8x16_t(), create_random_poly8x16_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsriq_n_p8::<1>(create_poly8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_poly8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255]).map_err(|e| format!("{e} | call: vsriq_n_p8::<1>(create_poly8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_poly8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p8::<1>(create_random_poly8x16_t(), create_random_poly8x16_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p8_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsriq_n_p8::<1>(create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127]).map_err(|e| format!("{e} | call: vsriq_n_p8::<1>(create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p8::<1>(create_random_poly8x16_t(), create_random_poly8x16_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p8_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsriq_n_p8::<1>(create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128]).map_err(|e| format!("{e} | call: vsriq_n_p8::<1>(create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p8::<1>(create_random_poly8x16_t(), create_random_poly8x16_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vsri_n_p16::<1>(create_poly16x4_t_from([1, 2, 3, 4]), create_poly16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[2, 3, 3, 4]).map_err(|e| format!("{e} | call: vsri_n_p16::<1>(create_poly16x4_t_from([1, 2, 3, 4]), create_poly16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p16::<1>(create_random_poly16x4_t(), create_random_poly16x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vsri_n_p16::<1>(create_poly16x4_t_from([0, 65535, 2, 65533]), create_poly16x4_t_from([10, 9, 12, 7])));
        check_array_equality(&result, &[5, 32772, 6, 32771]).map_err(|e| format!("{e} | call: vsri_n_p16::<1>(create_poly16x4_t_from([0, 65535, 2, 65533]), create_poly16x4_t_from([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p16::<1>(create_random_poly16x4_t(), create_random_poly16x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vsri_n_p16::<1>(create_poly16x4_t_from([100, 200, 300, 400]), create_poly16x4_t_from([110, 210, 310, 410])));
        check_array_equality(&result, &[55, 105, 155, 205]).map_err(|e| format!("{e} | call: vsri_n_p16::<1>(create_poly16x4_t_from([100, 200, 300, 400]), create_poly16x4_t_from([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p16::<1>(create_random_poly16x4_t(), create_random_poly16x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vsri_n_p16::<1>(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: vsri_n_p16::<1>(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p16::<1>(create_random_poly16x4_t(), create_random_poly16x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vsri_n_p16::<1>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535]).map_err(|e| format!("{e} | call: vsri_n_p16::<1>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p16::<1>(create_random_poly16x4_t(), create_random_poly16x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vsri_n_p16::<1>(create_poly16x4_t_from([0, 0, 0, 0]), create_poly16x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: vsri_n_p16::<1>(create_poly16x4_t_from([0, 0, 0, 0]), create_poly16x4_t_from([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p16::<1>(create_random_poly16x4_t(), create_random_poly16x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vsri_n_p16::<1>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535]).map_err(|e| format!("{e} | call: vsri_n_p16::<1>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p16::<1>(create_random_poly16x4_t(), create_random_poly16x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vsri_n_p16::<1>(create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]), create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 65535, 0, 65535]).map_err(|e| format!("{e} | call: vsri_n_p16::<1>(create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]), create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p16::<1>(create_random_poly16x4_t(), create_random_poly16x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vsri_n_p16::<1>(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767]).map_err(|e| format!("{e} | call: vsri_n_p16::<1>(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p16::<1>(create_random_poly16x4_t(), create_random_poly16x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsri_n_p16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vsri_n_p16::<1>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[32768, 32768, 32768, 32768]).map_err(|e| format!("{e} | call: vsri_n_p16::<1>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p16::<1>(create_random_poly16x4_t(), create_random_poly16x4_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p16() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsriq_n_p16::<1>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4, 5, 5, 6, 6, 7, 7, 8]).map_err(|e| format!("{e} | call: vsriq_n_p16::<1>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p16::<1>(create_random_poly16x8_t(), create_random_poly16x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsriq_n_p16::<1>(create_poly16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_poly16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[5, 32772, 6, 32771, 7, 32770, 8, 32769]).map_err(|e| format!("{e} | call: vsriq_n_p16::<1>(create_poly16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_poly16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p16::<1>(create_random_poly16x8_t(), create_random_poly16x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsriq_n_p16::<1>(create_poly16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_poly16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[55, 105, 155, 205, 255, 305, 355, 405]).map_err(|e| format!("{e} | call: vsriq_n_p16::<1>(create_poly16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_poly16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p16::<1>(create_random_poly16x8_t(), create_random_poly16x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsriq_n_p16::<1>(create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: vsriq_n_p16::<1>(create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p16::<1>(create_random_poly16x8_t(), create_random_poly16x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsriq_n_p16::<1>(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| format!("{e} | call: vsriq_n_p16::<1>(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p16::<1>(create_random_poly16x8_t(), create_random_poly16x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsriq_n_p16::<1>(create_poly16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_poly16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: vsriq_n_p16::<1>(create_poly16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_poly16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p16::<1>(create_random_poly16x8_t(), create_random_poly16x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsriq_n_p16::<1>(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| format!("{e} | call: vsriq_n_p16::<1>(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p16::<1>(create_random_poly16x8_t(), create_random_poly16x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsriq_n_p16::<1>(create_poly16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_poly16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 65535, 0, 65535, 0, 65535, 0, 65535]).map_err(|e| format!("{e} | call: vsriq_n_p16::<1>(create_poly16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_poly16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p16::<1>(create_random_poly16x8_t(), create_random_poly16x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsriq_n_p16::<1>(create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| format!("{e} | call: vsriq_n_p16::<1>(create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p16::<1>(create_random_poly16x8_t(), create_random_poly16x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vsriq_n_p16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsriq_n_p16::<1>(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768]).map_err(|e| format!("{e} | call: vsriq_n_p16::<1>(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p16::<1>(create_random_poly16x8_t(), create_random_poly16x8_t());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_f32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x2_t_from([2.0, 3.0]);
        vst1_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_f32_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x2_t_from([0.0f32, -1.0f32]);
        vst1_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_f32_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x2_t_from([100.0f32, 200.0f32]);
        vst1_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_f32_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x2_t_from([f32::MIN, f32::MIN]);
        vst1_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_f32_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x2_t_from([f32::MAX, f32::MAX]);
        vst1_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_f32_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x2_t_from([0.0, 0.0]);
        vst1_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_f32_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x2_t_from([f32::NAN, f32::NAN]);
        vst1_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_f32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]);
        vst1_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_f32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x4_t_from([2.0, 3.0, 4.0, 5.0]);
        vst1q_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_f32_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]);
        vst1q_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_f32_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]);
        vst1q_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_f32_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        vst1q_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_f32_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        vst1q_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_f32_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]);
        vst1q_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_f32_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        vst1q_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_f32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        vst1q_f32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s8() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s8_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]);
        vst1_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s8_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32]);
        vst1_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s8_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        vst1_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s8_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        vst1_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s8_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        vst1_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s8_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]);
        vst1_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        vst1_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s8() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        vst1q_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s8_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x16_t_from([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        vst1q_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s8_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x16_t_from([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]);
        vst1q_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s8_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        vst1q_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s8_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        vst1q_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s8_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        vst1q_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s8_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        vst1q_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        vst1q_s8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s16() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x4_t_from([2, 3, 4, 5]);
        vst1_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s16_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x4_t_from([0, -1, 2, -3]);
        vst1_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s16_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x4_t_from([100, 200, 300, 400]);
        vst1_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s16_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        vst1_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s16_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        vst1_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s16_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x4_t_from([0, 0, 0, 0]);
        vst1_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s16_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x4_t_from([-1, -1, -1, -1]);
        vst1_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]);
        vst1_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s16() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1q_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s16_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]);
        vst1q_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s16_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]);
        vst1q_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s16_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        vst1q_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s16_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        vst1q_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s16_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        vst1q_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s16_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]);
        vst1q_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        vst1q_s16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x2_t_from([2, 3]);
        vst1_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s32_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x2_t_from([0, -1]);
        vst1_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s32_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x2_t_from([100, 200]);
        vst1_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s32_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x2_t_from([i32::MIN, i32::MIN]);
        vst1_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s32_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x2_t_from([i32::MAX, i32::MAX]);
        vst1_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s32_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x2_t_from([0, 0]);
        vst1_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s32_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x2_t_from([-1, -1]);
        vst1_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x2_t_from([i32::MIN, i32::MAX]);
        vst1_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x4_t_from([2, 3, 4, 5]);
        vst1q_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s32_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x4_t_from([0, -1, 2, -3]);
        vst1q_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s32_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x4_t_from([100, 200, 300, 400]);
        vst1q_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s32_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        vst1q_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s32_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        vst1q_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s32_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x4_t_from([0, 0, 0, 0]);
        vst1q_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s32_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x4_t_from([-1, -1, -1, -1]);
        vst1q_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]);
        vst1q_s32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x1_t_from([2]);
        vst1_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s64_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x1_t_from([0]);
        vst1_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s64_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x1_t_from([100]);
        vst1_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s64_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x1_t_from([i64::MIN]);
        vst1_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s64_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x1_t_from([i64::MAX]);
        vst1_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s64_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x1_t_from([0]);
        vst1_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s64_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x1_t_from([-1]);
        vst1_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_s64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x1_t_from([i64::MIN]);
        vst1_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x2_t_from([2, 3]);
        vst1q_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s64_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x2_t_from([0, -1]);
        vst1q_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s64_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x2_t_from([100, 200]);
        vst1q_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s64_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x2_t_from([i64::MIN, i64::MIN]);
        vst1q_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s64_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x2_t_from([i64::MAX, i64::MAX]);
        vst1q_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s64_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x2_t_from([0, 0]);
        vst1q_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s64_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x2_t_from([-1, -1]);
        vst1q_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_s64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x2_t_from([i64::MIN, i64::MAX]);
        vst1q_s64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u8_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]);
        vst1_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u8_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]);
        vst1_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u8_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]);
        vst1_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u8_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u8_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        vst1_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u8_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]);
        vst1_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        vst1q_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u8_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]);
        vst1q_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u8_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]);
        vst1q_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u8_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]);
        vst1q_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u8_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1q_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u8_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        vst1q_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u8_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1q_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]);
        vst1q_u8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u16() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x4_t_from([2, 3, 4, 5]);
        vst1_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u16_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x4_t_from([0, 65535, 2, 65533]);
        vst1_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u16_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x4_t_from([100, 200, 300, 400]);
        vst1_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u16_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]);
        vst1_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u16_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        vst1_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u16_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x4_t_from([0, 0, 0, 0]);
        vst1_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u16_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        vst1_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]);
        vst1_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u16() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1q_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u16_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]);
        vst1q_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u16_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]);
        vst1q_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u16_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]);
        vst1q_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u16_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        vst1q_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u16_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        vst1q_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u16_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        vst1q_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]);
        vst1q_u16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x2_t_from([2, 3]);
        vst1_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u32_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x2_t_from([0, 4294967295]);
        vst1_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u32_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x2_t_from([100, 200]);
        vst1_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u32_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x2_t_from([u32::MIN, u32::MIN]);
        vst1_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u32_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x2_t_from([u32::MAX, u32::MAX]);
        vst1_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u32_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x2_t_from([0, 0]);
        vst1_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u32_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x2_t_from([u32::MAX, u32::MAX]);
        vst1_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x2_t_from([u32::MIN, u32::MAX]);
        vst1_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x4_t_from([2, 3, 4, 5]);
        vst1q_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u32_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x4_t_from([0, 4294967295, 2, 4294967293]);
        vst1q_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u32_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x4_t_from([100, 200, 300, 400]);
        vst1q_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u32_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]);
        vst1q_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u32_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]);
        vst1q_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u32_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x4_t_from([0, 0, 0, 0]);
        vst1q_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u32_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]);
        vst1q_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]);
        vst1q_u32(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x1_t_from([2]);
        vst1_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u64_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x1_t_from([0]);
        vst1_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u64_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x1_t_from([100]);
        vst1_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u64_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x1_t_from([u64::MIN]);
        vst1_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u64_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x1_t_from([u64::MAX]);
        vst1_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u64_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x1_t_from([0]);
        vst1_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u64_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x1_t_from([u64::MAX]);
        vst1_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_u64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x1_t_from([u64::MIN]);
        vst1_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x2_t_from([2, 3]);
        vst1q_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u64_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x2_t_from([0, 18446744073709551615]);
        vst1q_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u64_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x2_t_from([100, 200]);
        vst1q_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u64_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x2_t_from([u64::MIN, u64::MIN]);
        vst1q_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u64_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x2_t_from([u64::MAX, u64::MAX]);
        vst1q_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u64_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x2_t_from([0, 0]);
        vst1q_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u64_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x2_t_from([u64::MAX, u64::MAX]);
        vst1q_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_u64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x2_t_from([u64::MIN, u64::MAX]);
        vst1q_u64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p8() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p8_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]);
        vst1_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p8_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]);
        vst1_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p8_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]);
        vst1_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p8_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p8_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        vst1_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p8_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]);
        vst1_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p8() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        vst1q_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p8_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]);
        vst1q_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p8_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]);
        vst1q_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p8_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]);
        vst1q_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p8_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1q_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p8_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        vst1q_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p8_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1q_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]);
        vst1q_p8(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p16() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x4_t_from([2, 3, 4, 5]);
        vst1_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p16_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x4_t_from([0, 65535, 2, 65533]);
        vst1_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p16_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x4_t_from([100, 200, 300, 400]);
        vst1_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p16_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]);
        vst1_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p16_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        vst1_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p16_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x4_t_from([0, 0, 0, 0]);
        vst1_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p16_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        vst1_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]);
        vst1_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p16() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1q_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p16_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]);
        vst1q_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p16_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]);
        vst1q_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p16_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]);
        vst1q_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p16_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        vst1q_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p16_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        vst1q_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p16_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        vst1q_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]);
        vst1q_p16(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x1_t_from([2]);
        vst1_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p64_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x1_t_from([0]);
        vst1_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p64_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x1_t_from([100]);
        vst1_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p64_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x1_t_from([u64::MIN]);
        vst1_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p64_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x1_t_from([u64::MAX]);
        vst1_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p64_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x1_t_from([0]);
        vst1_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p64_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x1_t_from([u64::MAX]);
        vst1_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1_p64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x1_t_from([u64::MIN]);
        vst1_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x2_t_from([2, 3]);
        vst1q_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p64_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x2_t_from([0, 18446744073709551615]);
        vst1q_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p64_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x2_t_from([100, 200]);
        vst1q_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p64_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x2_t_from([u64::MIN, u64::MIN]);
        vst1q_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p64_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x2_t_from([u64::MAX, u64::MAX]);
        vst1q_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p64_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x2_t_from([0, 0]);
        vst1q_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p64_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x2_t_from([u64::MAX, u64::MAX]);
        vst1q_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vst1q_p64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x2_t_from([u64::MIN, u64::MAX]);
        vst1q_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_f32() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f32; 16]);
        let b = create_float32x2_t_from([2.0, 3.0]);
        vst1_lane_f32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_f32_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f32; 16]);
        let b = create_float32x2_t_from([0.0f32, -1.0f32]);
        vst1_lane_f32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_f32_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f32; 16]);
        let b = create_float32x2_t_from([100.0f32, 200.0f32]);
        vst1_lane_f32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_f32_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f32; 16]);
        let b = create_float32x2_t_from([f32::MIN, f32::MIN]);
        vst1_lane_f32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_f32_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f32; 16]);
        let b = create_float32x2_t_from([f32::MAX, f32::MAX]);
        vst1_lane_f32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_f32_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f32; 16]);
        let b = create_float32x2_t_from([0.0, 0.0]);
        vst1_lane_f32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_f32_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f32; 16]);
        let b = create_float32x2_t_from([f32::NAN, f32::NAN]);
        vst1_lane_f32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_f32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f32; 16]);
        let b = create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]);
        vst1_lane_f32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_f32() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f32; 16]);
        let b = create_float32x4_t_from([2.0, 3.0, 4.0, 5.0]);
        vst1q_lane_f32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_f32_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f32; 16]);
        let b = create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]);
        vst1q_lane_f32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_f32_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f32; 16]);
        let b = create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]);
        vst1q_lane_f32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_f32_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f32; 16]);
        let b = create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        vst1q_lane_f32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_f32_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f32; 16]);
        let b = create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        vst1q_lane_f32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_f32_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f32; 16]);
        let b = create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]);
        vst1q_lane_f32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_f32_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f32; 16]);
        let b = create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        vst1q_lane_f32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_f32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f32; 16]);
        let b = create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        vst1q_lane_f32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s8() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i8; 64]);
        let b = create_int8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1_lane_s8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s8_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i8; 64]);
        let b = create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]);
        vst1_lane_s8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s8_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i8; 64]);
        let b = create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32]);
        vst1_lane_s8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s8_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i8; 64]);
        let b = create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        vst1_lane_s8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s8_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i8; 64]);
        let b = create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        vst1_lane_s8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s8_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i8; 64]);
        let b = create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        vst1_lane_s8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s8_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i8; 64]);
        let b = create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]);
        vst1_lane_s8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i8; 64]);
        let b = create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        vst1_lane_s8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s8() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i8; 64]);
        let b = create_int8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        vst1q_lane_s8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s8_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i8; 64]);
        let b = create_int8x16_t_from([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        vst1q_lane_s8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s8_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i8; 64]);
        let b = create_int8x16_t_from([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]);
        vst1q_lane_s8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s8_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i8; 64]);
        let b = create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        vst1q_lane_s8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s8_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i8; 64]);
        let b = create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        vst1q_lane_s8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s8_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i8; 64]);
        let b = create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        vst1q_lane_s8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s8_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i8; 64]);
        let b = create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        vst1q_lane_s8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i8; 64]);
        let b = create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        vst1q_lane_s8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s16() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i16; 32]);
        let b = create_int16x4_t_from([2, 3, 4, 5]);
        vst1_lane_s16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s16_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i16; 32]);
        let b = create_int16x4_t_from([0, -1, 2, -3]);
        vst1_lane_s16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s16_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i16; 32]);
        let b = create_int16x4_t_from([100, 200, 300, 400]);
        vst1_lane_s16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s16_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i16; 32]);
        let b = create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        vst1_lane_s16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s16_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i16; 32]);
        let b = create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        vst1_lane_s16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s16_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i16; 32]);
        let b = create_int16x4_t_from([0, 0, 0, 0]);
        vst1_lane_s16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s16_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i16; 32]);
        let b = create_int16x4_t_from([-1, -1, -1, -1]);
        vst1_lane_s16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i16; 32]);
        let b = create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]);
        vst1_lane_s16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s16() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i16; 32]);
        let b = create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1q_lane_s16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s16_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i16; 32]);
        let b = create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]);
        vst1q_lane_s16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s16_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i16; 32]);
        let b = create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]);
        vst1q_lane_s16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s16_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i16; 32]);
        let b = create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        vst1q_lane_s16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s16_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i16; 32]);
        let b = create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        vst1q_lane_s16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s16_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i16; 32]);
        let b = create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        vst1q_lane_s16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s16_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i16; 32]);
        let b = create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]);
        vst1q_lane_s16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i16; 32]);
        let b = create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        vst1q_lane_s16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s32() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i32; 16]);
        let b = create_int32x2_t_from([2, 3]);
        vst1_lane_s32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s32_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i32; 16]);
        let b = create_int32x2_t_from([0, -1]);
        vst1_lane_s32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s32_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i32; 16]);
        let b = create_int32x2_t_from([100, 200]);
        vst1_lane_s32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s32_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i32; 16]);
        let b = create_int32x2_t_from([i32::MIN, i32::MIN]);
        vst1_lane_s32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s32_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i32; 16]);
        let b = create_int32x2_t_from([i32::MAX, i32::MAX]);
        vst1_lane_s32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s32_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i32; 16]);
        let b = create_int32x2_t_from([0, 0]);
        vst1_lane_s32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s32_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i32; 16]);
        let b = create_int32x2_t_from([-1, -1]);
        vst1_lane_s32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_s32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i32; 16]);
        let b = create_int32x2_t_from([i32::MIN, i32::MAX]);
        vst1_lane_s32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s32() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i32; 16]);
        let b = create_int32x4_t_from([2, 3, 4, 5]);
        vst1q_lane_s32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s32_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i32; 16]);
        let b = create_int32x4_t_from([0, -1, 2, -3]);
        vst1q_lane_s32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s32_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i32; 16]);
        let b = create_int32x4_t_from([100, 200, 300, 400]);
        vst1q_lane_s32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s32_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i32; 16]);
        let b = create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        vst1q_lane_s32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s32_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i32; 16]);
        let b = create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        vst1q_lane_s32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s32_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i32; 16]);
        let b = create_int32x4_t_from([0, 0, 0, 0]);
        vst1q_lane_s32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s32_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i32; 16]);
        let b = create_int32x4_t_from([-1, -1, -1, -1]);
        vst1q_lane_s32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i32; 16]);
        let b = create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]);
        vst1q_lane_s32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s64() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i64; 8]);
        let b = create_int64x2_t_from([2, 3]);
        vst1q_lane_s64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s64_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i64; 8]);
        let b = create_int64x2_t_from([0, -1]);
        vst1q_lane_s64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s64_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i64; 8]);
        let b = create_int64x2_t_from([100, 200]);
        vst1q_lane_s64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s64_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i64; 8]);
        let b = create_int64x2_t_from([i64::MIN, i64::MIN]);
        vst1q_lane_s64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s64_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i64; 8]);
        let b = create_int64x2_t_from([i64::MAX, i64::MAX]);
        vst1q_lane_s64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s64_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i64; 8]);
        let b = create_int64x2_t_from([0, 0]);
        vst1q_lane_s64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s64_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i64; 8]);
        let b = create_int64x2_t_from([-1, -1]);
        vst1q_lane_s64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_s64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1i64; 8]);
        let b = create_int64x2_t_from([i64::MIN, i64::MAX]);
        vst1q_lane_s64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_uint8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1_lane_u8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u8_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]);
        vst1_lane_u8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u8_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]);
        vst1_lane_u8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u8_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]);
        vst1_lane_u8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u8_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1_lane_u8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u8_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        vst1_lane_u8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u8_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1_lane_u8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]);
        vst1_lane_u8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_uint8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        vst1q_lane_u8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u8_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_uint8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]);
        vst1q_lane_u8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u8_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_uint8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]);
        vst1q_lane_u8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u8_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]);
        vst1q_lane_u8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u8_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1q_lane_u8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u8_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        vst1q_lane_u8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u8_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1q_lane_u8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]);
        vst1q_lane_u8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u16() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 32]);
        let b = create_uint16x4_t_from([2, 3, 4, 5]);
        vst1_lane_u16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u16_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 32]);
        let b = create_uint16x4_t_from([0, 65535, 2, 65533]);
        vst1_lane_u16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u16_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 32]);
        let b = create_uint16x4_t_from([100, 200, 300, 400]);
        vst1_lane_u16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u16_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 32]);
        let b = create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]);
        vst1_lane_u16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u16_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 32]);
        let b = create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        vst1_lane_u16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u16_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 32]);
        let b = create_uint16x4_t_from([0, 0, 0, 0]);
        vst1_lane_u16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u16_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 32]);
        let b = create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        vst1_lane_u16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 32]);
        let b = create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]);
        vst1_lane_u16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u16() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 32]);
        let b = create_uint16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1q_lane_u16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u16_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 32]);
        let b = create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]);
        vst1q_lane_u16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u16_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 32]);
        let b = create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]);
        vst1q_lane_u16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u16_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 32]);
        let b = create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]);
        vst1q_lane_u16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u16_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 32]);
        let b = create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        vst1q_lane_u16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u16_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 32]);
        let b = create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        vst1q_lane_u16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u16_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 32]);
        let b = create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        vst1q_lane_u16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u16; 32]);
        let b = create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]);
        vst1q_lane_u16::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u32() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u32; 16]);
        let b = create_uint32x2_t_from([2, 3]);
        vst1_lane_u32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u32_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u32; 16]);
        let b = create_uint32x2_t_from([0, 4294967295]);
        vst1_lane_u32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u32_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u32; 16]);
        let b = create_uint32x2_t_from([100, 200]);
        vst1_lane_u32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u32_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u32; 16]);
        let b = create_uint32x2_t_from([u32::MIN, u32::MIN]);
        vst1_lane_u32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u32_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u32; 16]);
        let b = create_uint32x2_t_from([u32::MAX, u32::MAX]);
        vst1_lane_u32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u32_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u32; 16]);
        let b = create_uint32x2_t_from([0, 0]);
        vst1_lane_u32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u32_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u32; 16]);
        let b = create_uint32x2_t_from([u32::MAX, u32::MAX]);
        vst1_lane_u32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_u32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u32; 16]);
        let b = create_uint32x2_t_from([u32::MIN, u32::MAX]);
        vst1_lane_u32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u32() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u32; 16]);
        let b = create_uint32x4_t_from([2, 3, 4, 5]);
        vst1q_lane_u32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u32_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u32; 16]);
        let b = create_uint32x4_t_from([0, 4294967295, 2, 4294967293]);
        vst1q_lane_u32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u32_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u32; 16]);
        let b = create_uint32x4_t_from([100, 200, 300, 400]);
        vst1q_lane_u32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u32_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u32; 16]);
        let b = create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]);
        vst1q_lane_u32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u32_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u32; 16]);
        let b = create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]);
        vst1q_lane_u32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u32_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u32; 16]);
        let b = create_uint32x4_t_from([0, 0, 0, 0]);
        vst1q_lane_u32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u32_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u32; 16]);
        let b = create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]);
        vst1q_lane_u32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u32; 16]);
        let b = create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]);
        vst1q_lane_u32::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u64() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u64; 8]);
        let b = create_uint64x2_t_from([2, 3]);
        vst1q_lane_u64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u64_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u64; 8]);
        let b = create_uint64x2_t_from([0, 18446744073709551615]);
        vst1q_lane_u64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u64_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u64; 8]);
        let b = create_uint64x2_t_from([100, 200]);
        vst1q_lane_u64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u64_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u64; 8]);
        let b = create_uint64x2_t_from([u64::MIN, u64::MIN]);
        vst1q_lane_u64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u64_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u64; 8]);
        let b = create_uint64x2_t_from([u64::MAX, u64::MAX]);
        vst1q_lane_u64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u64_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u64; 8]);
        let b = create_uint64x2_t_from([0, 0]);
        vst1q_lane_u64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u64_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u64; 8]);
        let b = create_uint64x2_t_from([u64::MAX, u64::MAX]);
        vst1q_lane_u64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_u64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u64; 8]);
        let b = create_uint64x2_t_from([u64::MIN, u64::MAX]);
        vst1q_lane_u64::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_p8() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_poly8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1_lane_p8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_p8_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_poly8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]);
        vst1_lane_p8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_p8_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_poly8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]);
        vst1_lane_p8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_p8_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]);
        vst1_lane_p8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_p8_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1_lane_p8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_p8_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        vst1_lane_p8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_p8_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1_lane_p8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1_lane_p8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]);
        vst1_lane_p8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_p8() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_poly8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        vst1q_lane_p8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_p8_normal2() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_poly8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]);
        vst1q_lane_p8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_p8_normal3() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_poly8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]);
        vst1q_lane_p8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_p8_boundary_min() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]);
        vst1q_lane_p8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_p8_boundary_max() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1q_lane_p8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_p8_boundary_zero() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_poly8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        vst1q_lane_p8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_p8_boundary_allones() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1q_lane_p8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vst1q_lane_p8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u8; 64]);
        let b = create_poly8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]);
        vst1q_lane_p8::<0>(ptr_a.0.as_mut_ptr(), b);
    }
    Ok(())
}
