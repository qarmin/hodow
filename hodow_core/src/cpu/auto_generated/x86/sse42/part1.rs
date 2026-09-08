#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrm_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpistrm::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_cmpistrm::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrm::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrm() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrm_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrm_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpistrm::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_cmpistrm::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrm::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrm_normal2() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrm_normal2_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrm_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpistrm::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_cmpistrm::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrm::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrm_normal3() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrm_normal3_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrm_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpistrm::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_cmpistrm::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrm::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrm_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrm_boundary_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrm_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpistrm::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[65535, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cmpistrm::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrm::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrm_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrm_boundary_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrm_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpistrm::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_cmpistrm::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrm::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrm_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrm_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrm_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpistrm::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[65535, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cmpistrm::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrm::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrm_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrm_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrm_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpistrm::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_cmpistrm::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrm::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrm_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrm_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrm_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpistrm::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_cmpistrm::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrm::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrm_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrm_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrm_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpistrm::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_cmpistrm::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrm::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrm_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrm_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrm_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpistrm::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_cmpistrm::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrm::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrm_imm_0() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrm_imm_0_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrm_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpistrm::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_cmpistrm::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrm::<1>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrm_imm_1() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrm_imm_1_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistri_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistri::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 16).map_err(|e| format!("{e} | call: _mm_cmpistri::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistri::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistri() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistri_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistri_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistri::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]));
        check_int_equality(result as i32, 16).map_err(|e| format!("{e} | call: _mm_cmpistri::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistri::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistri_normal2() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistri_normal2_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistri_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistri::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]));
        check_int_equality(result as i32, 16).map_err(|e| format!("{e} | call: _mm_cmpistri::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistri::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistri_normal3() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistri_normal3_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistri_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistri::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 16).map_err(|e| format!("{e} | call: _mm_cmpistri::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistri::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistri_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistri_boundary_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistri_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistri::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistri::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistri::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistri_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistri_boundary_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistri_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistri::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result as i32, 16).map_err(|e| format!("{e} | call: _mm_cmpistri::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistri::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistri_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistri_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistri_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistri::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistri::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistri::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistri_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistri_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistri_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistri::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result as i32, 16).map_err(|e| format!("{e} | call: _mm_cmpistri::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistri::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistri_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistri_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistri_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistri::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 16).map_err(|e| format!("{e} | call: _mm_cmpistri::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistri::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistri_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistri_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistri_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistri::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 16).map_err(|e| format!("{e} | call: _mm_cmpistri::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistri::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistri_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistri_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistri_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistri::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 16).map_err(|e| format!("{e} | call: _mm_cmpistri::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistri::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistri_imm_0() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistri_imm_0_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistri_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistri::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 8).map_err(|e| format!("{e} | call: _mm_cmpistri::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistri::<1>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistri_imm_1() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistri_imm_1_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrz_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrz::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrz::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrz::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrz() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrz_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrz_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrz::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrz::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrz::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrz_normal2() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrz_normal2_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrz_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrz::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrz::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrz::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrz_normal3() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrz_normal3_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrz_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrz::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrz::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrz::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrz_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrz_boundary_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrz_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrz::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistrz::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrz::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrz_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrz_boundary_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrz_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrz::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrz::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrz::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrz_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrz_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrz_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrz::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistrz::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrz::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrz_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrz_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrz_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrz::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrz::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrz::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrz_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrz_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrz_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrz::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistrz::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrz::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrz_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrz_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrz_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrz::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrz::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrz::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrz_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrz_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrz_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrz::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrz::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrz::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrz_imm_0() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrz_imm_0_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrz_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrz::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrz::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrz::<1>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrz_imm_1() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrz_imm_1_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrc_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrc::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistrc::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrc::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrc() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrc_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrc_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrc::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistrc::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrc::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrc_normal2() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrc_normal2_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrc_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrc::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistrc::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrc::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrc_normal3() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrc_normal3_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrc_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrc::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistrc::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrc::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrc_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrc_boundary_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrc_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrc::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrc::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrc::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrc_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrc_boundary_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrc_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrc::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistrc::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrc::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrc_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrc_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrc_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrc::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrc::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrc::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrc_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrc_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrc_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrc::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistrc::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrc::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrc_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrc_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrc_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrc::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistrc::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrc::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrc_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrc_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrc_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrc::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistrc::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrc::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrc_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrc_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrc_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrc::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistrc::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrc::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrc_imm_0() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrc_imm_0_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrc_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrc::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistrc::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrc::<1>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrc_imm_1() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrc_imm_1_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrs_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrs::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrs::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrs::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrs() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrs_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrs_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrs::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrs::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrs::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrs_normal2() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrs_normal2_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrs_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrs::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrs::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrs::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrs_normal3() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrs_normal3_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrs_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrs::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrs::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrs::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrs_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrs_boundary_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrs_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrs::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistrs::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrs::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrs_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrs_boundary_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrs_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrs::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrs::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrs::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrs_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrs_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrs_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrs::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistrs::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrs::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrs_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrs_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrs_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrs::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrs::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrs::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrs_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrs_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrs_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrs::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrs::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrs::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrs_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrs_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrs_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrs::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistrs::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrs::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrs_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrs_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrs_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrs::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrs::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrs::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrs_imm_0() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrs_imm_0_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistrs_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrs::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistrs::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistrs::<1>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistrs_imm_1() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistrs_imm_1_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistro_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistro::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistro::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistro::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistro() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistro_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistro_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistro::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistro::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistro::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistro_normal2() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistro_normal2_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistro_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistro::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistro::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistro::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistro_normal3() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistro_normal3_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistro_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistro::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistro::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistro::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistro_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistro_boundary_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistro_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistro::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistro::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistro::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistro_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistro_boundary_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistro_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistro::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistro::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistro::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistro_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistro_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistro_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistro::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistro::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistro::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistro_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistro_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistro_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistro::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistro::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistro::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistro_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistro_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistro_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistro::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistro::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistro::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistro_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistro_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistro_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistro::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistro::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistro::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistro_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistro_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistro_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistro::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistro::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistro::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistro_imm_0() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistro_imm_0_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistro_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistro::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistro::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistro::<1>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistro_imm_1() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistro_imm_1_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistra_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistra::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistra::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistra::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistra() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistra_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistra_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistra::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistra::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistra::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistra_normal2() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistra_normal2_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistra_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistra::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistra::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistra::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistra_normal3() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistra_normal3_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistra_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistra::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistra::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistra::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistra_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistra_boundary_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistra_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistra::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistra::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistra::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistra_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistra_boundary_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistra_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistra::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistra::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistra::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistra_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistra_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistra_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistra::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistra::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistra::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistra_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistra_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistra_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistra::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistra::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistra::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistra_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistra_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistra_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistra::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpistra::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistra::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistra_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistra_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistra_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistra::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistra::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistra::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistra_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistra_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistra_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistra::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistra::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistra::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistra_imm_0() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistra_imm_0_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpistra_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistra::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpistra::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpistra::<1>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpistra_imm_1() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpistra_imm_1_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrm_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpestrm::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32));
        check_array_equality(&result, &[750, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cmpestrm::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrm::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrm() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrm_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrm_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpestrm::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), 1i32, create__m128i_from_i32_array([10, 9, 12, 7]), 2i32));
        check_array_equality(&result, &[2, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cmpestrm::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), 1i32, create__m128i_from_i32_array([10, 9, 12, 7]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrm::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrm_normal2() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrm_normal2_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrm_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpestrm::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), 1i32, create__m128i_from_i32_array([110, 210, 310, 410]), 2i32));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_cmpestrm::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), 1i32, create__m128i_from_i32_array([110, 210, 310, 410]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrm::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrm_normal3() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrm_normal3_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrm_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpestrm::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32));
        check_array_equality(&result, &[3, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cmpestrm::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrm::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrm_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrm_boundary_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrm_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpestrm::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32));
        check_array_equality(&result, &[3, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cmpestrm::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrm::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrm_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrm_boundary_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrm_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpestrm::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), 1i32, create__m128i_from_i32_array([0, 0, 0, 0]), 2i32));
        check_array_equality(&result, &[3, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cmpestrm::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), 1i32, create__m128i_from_i32_array([0, 0, 0, 0]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrm::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrm_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrm_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrm_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpestrm::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), 1i32, create__m128i_from_i32_array([-1, -1, -1, -1]), 2i32));
        check_array_equality(&result, &[3, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cmpestrm::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), 1i32, create__m128i_from_i32_array([-1, -1, -1, -1]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrm::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrm_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrm_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrm_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpestrm::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 2i32));
        check_array_equality(&result, &[3, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cmpestrm::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrm::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrm_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrm_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrm_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpestrm::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_cmpestrm::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrm::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrm_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrm_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrm_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpestrm::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_cmpestrm::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrm::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrm_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrm_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrm_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpestrm::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32));
        check_array_equality(&result, &[750, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cmpestrm::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrm::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrm_imm_0() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrm_imm_0_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrm_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpestrm::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32));
        check_array_equality(&result, &[170, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cmpestrm::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrm::<1>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrm_imm_1() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrm_imm_1_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestri_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestri::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestri::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestri::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestri() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestri_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestri_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestri::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), 1i32, create__m128i_from_i32_array([10, 9, 12, 7]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestri::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), 1i32, create__m128i_from_i32_array([10, 9, 12, 7]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestri::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestri_normal2() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestri_normal2_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestri_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestri::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), 1i32, create__m128i_from_i32_array([110, 210, 310, 410]), 2i32);
        check_int_equality(result as i32, 16).map_err(|e| format!("{e} | call: _mm_cmpestri::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), 1i32, create__m128i_from_i32_array([110, 210, 310, 410]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestri::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestri_normal3() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestri_normal3_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestri_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestri::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestri::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestri::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestri_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestri_boundary_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestri_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestri::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestri::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestri::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestri_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestri_boundary_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestri_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestri::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), 1i32, create__m128i_from_i32_array([0, 0, 0, 0]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestri::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), 1i32, create__m128i_from_i32_array([0, 0, 0, 0]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestri::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestri_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestri_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestri_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestri::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), 1i32, create__m128i_from_i32_array([-1, -1, -1, -1]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestri::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), 1i32, create__m128i_from_i32_array([-1, -1, -1, -1]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestri::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestri_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestri_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestri_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestri::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestri::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestri::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestri_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestri_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestri_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestri::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32);
        check_int_equality(result as i32, 16).map_err(|e| format!("{e} | call: _mm_cmpestri::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestri::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestri_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestri_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestri_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestri::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32);
        check_int_equality(result as i32, 16).map_err(|e| format!("{e} | call: _mm_cmpestri::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestri::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestri_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestri_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestri_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestri::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestri::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestri::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestri_imm_0() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestri_imm_0_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestri_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestri::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestri::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestri::<1>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestri_imm_1() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestri_imm_1_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrz_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrz::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrz::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrz::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrz() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrz_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrz_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrz::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), 1i32, create__m128i_from_i32_array([10, 9, 12, 7]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrz::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), 1i32, create__m128i_from_i32_array([10, 9, 12, 7]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrz::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrz_normal2() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrz_normal2_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrz_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrz::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), 1i32, create__m128i_from_i32_array([110, 210, 310, 410]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrz::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), 1i32, create__m128i_from_i32_array([110, 210, 310, 410]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrz::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrz_normal3() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrz_normal3_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrz_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrz::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrz::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrz::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrz_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrz_boundary_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrz_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrz::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrz::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrz::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrz_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrz_boundary_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrz_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrz::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), 1i32, create__m128i_from_i32_array([0, 0, 0, 0]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrz::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), 1i32, create__m128i_from_i32_array([0, 0, 0, 0]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrz::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrz_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrz_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrz_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrz::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), 1i32, create__m128i_from_i32_array([-1, -1, -1, -1]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrz::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), 1i32, create__m128i_from_i32_array([-1, -1, -1, -1]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrz::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrz_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrz_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrz_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrz::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrz::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrz::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrz_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrz_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrz_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrz::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrz::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrz::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrz_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrz_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrz_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrz::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrz::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrz::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrz_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrz_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrz_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrz::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrz::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrz::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrz_imm_0() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrz_imm_0_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrz_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrz::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestrz::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrz::<1>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrz_imm_1() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrz_imm_1_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrc::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrc() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrc_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), 1i32, create__m128i_from_i32_array([10, 9, 12, 7]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrc::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), 1i32, create__m128i_from_i32_array([10, 9, 12, 7]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrc_normal2() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrc_normal2_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), 1i32, create__m128i_from_i32_array([110, 210, 310, 410]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestrc::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), 1i32, create__m128i_from_i32_array([110, 210, 310, 410]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrc_normal3() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrc_normal3_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrc_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrc_boundary_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrc_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrc_boundary_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), 1i32, create__m128i_from_i32_array([0, 0, 0, 0]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrc::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), 1i32, create__m128i_from_i32_array([0, 0, 0, 0]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrc_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrc_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), 1i32, create__m128i_from_i32_array([-1, -1, -1, -1]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrc::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), 1i32, create__m128i_from_i32_array([-1, -1, -1, -1]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrc_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrc_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrc_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrc_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrc_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrc_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrc_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrc_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrc::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrc_imm_0() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrc_imm_0_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrc::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrc::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrc::<1>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrc_imm_1() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrc_imm_1_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrs_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrs::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrs::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrs::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrs() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrs_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrs_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrs::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), 1i32, create__m128i_from_i32_array([10, 9, 12, 7]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrs::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), 1i32, create__m128i_from_i32_array([10, 9, 12, 7]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrs::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrs_normal2() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrs_normal2_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrs_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrs::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), 1i32, create__m128i_from_i32_array([110, 210, 310, 410]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrs::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), 1i32, create__m128i_from_i32_array([110, 210, 310, 410]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrs::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrs_normal3() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrs_normal3_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrs_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrs::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrs::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrs::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrs_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrs_boundary_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrs_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrs::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrs::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrs::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrs_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrs_boundary_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrs_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrs::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), 1i32, create__m128i_from_i32_array([0, 0, 0, 0]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrs::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), 1i32, create__m128i_from_i32_array([0, 0, 0, 0]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrs::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrs_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrs_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrs_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrs::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), 1i32, create__m128i_from_i32_array([-1, -1, -1, -1]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrs::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), 1i32, create__m128i_from_i32_array([-1, -1, -1, -1]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrs::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrs_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrs_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrs_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrs::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrs::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrs::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrs_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrs_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrs_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrs::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrs::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrs::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrs_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrs_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrs_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrs::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrs::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrs::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrs_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrs_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrs_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrs::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrs::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrs::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrs_imm_0() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrs_imm_0_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrs_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrs::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestrs::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestrs::<1>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestrs_imm_1() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestrs_imm_1_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestro_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestro::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestro::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestro::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestro() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestro_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestro_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestro::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), 1i32, create__m128i_from_i32_array([10, 9, 12, 7]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestro::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), 1i32, create__m128i_from_i32_array([10, 9, 12, 7]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestro::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestro_normal2() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestro_normal2_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestro_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestro::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), 1i32, create__m128i_from_i32_array([110, 210, 310, 410]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestro::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), 1i32, create__m128i_from_i32_array([110, 210, 310, 410]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestro::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestro_normal3() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestro_normal3_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestro_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestro::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestro::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestro::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestro_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestro_boundary_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestro_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestro::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestro::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestro::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestro_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestro_boundary_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestro_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestro::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), 1i32, create__m128i_from_i32_array([0, 0, 0, 0]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestro::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), 1i32, create__m128i_from_i32_array([0, 0, 0, 0]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestro::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestro_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestro_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestro_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestro::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), 1i32, create__m128i_from_i32_array([-1, -1, -1, -1]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestro::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), 1i32, create__m128i_from_i32_array([-1, -1, -1, -1]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestro::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestro_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestro_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestro_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestro::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 2i32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmpestro::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestro::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestro_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestro_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestro_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestro::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestro::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestro::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestro_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestro_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestro_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestro::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestro::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestro::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestro_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestro_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestro_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestro::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestro::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestro::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestro_imm_0() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestro_imm_0_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestro_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestro::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestro::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestro::<1>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestro_imm_1() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestro_imm_1_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestra_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestra::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestra::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestra::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestra() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestra_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestra_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestra::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), 1i32, create__m128i_from_i32_array([10, 9, 12, 7]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestra::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), 1i32, create__m128i_from_i32_array([10, 9, 12, 7]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestra::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestra_normal2() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestra_normal2_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestra_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestra::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), 1i32, create__m128i_from_i32_array([110, 210, 310, 410]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestra::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), 1i32, create__m128i_from_i32_array([110, 210, 310, 410]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestra::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestra_normal3() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestra_normal3_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestra_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestra::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestra::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestra::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestra_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestra_boundary_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestra_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestra::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestra::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestra::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestra_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestra_boundary_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestra_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestra::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), 1i32, create__m128i_from_i32_array([0, 0, 0, 0]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestra::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), 1i32, create__m128i_from_i32_array([0, 0, 0, 0]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestra::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestra_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestra_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestra_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestra::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), 1i32, create__m128i_from_i32_array([-1, -1, -1, -1]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestra::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), 1i32, create__m128i_from_i32_array([-1, -1, -1, -1]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestra::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestra_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestra_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestra_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestra::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestra::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestra::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestra_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestra_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestra_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestra::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestra::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestra::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestra_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestra_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestra_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestra::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestra::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestra::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestra_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestra_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestra_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestra::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestra::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestra::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestra_imm_0() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestra_imm_0_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestra_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestra::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmpestra::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpestra::<1>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_cmpestra_imm_1() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_cmpestra_imm_1_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_crc32_u8_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_crc32_u8(1u32, 2u8);
        check_int_equality(result as i32, 324072436).map_err(|e| format!("{e} | call: _mm_crc32_u8(1u32, 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_crc32_u8(rand::random::<u32>(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_crc32_u8() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_crc32_u8_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_crc32_u16_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_crc32_u16(1u32, 2u16);
        check_int_equality(result as i32, 887597209).map_err(|e| format!("{e} | call: _mm_crc32_u16(1u32, 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_crc32_u16(rand::random::<u32>(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_crc32_u16() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_crc32_u16_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_crc32_u32_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_crc32_u32(1u32, 2u32);
        check_int_equality(result as i32, 1646430521).map_err(|e| format!("{e} | call: _mm_crc32_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_crc32_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse42_mm_crc32_u32() -> Result<(), String> {
    unsafe { test_x86_sse42_mm_crc32_u32_impl() }
}
