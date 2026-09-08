#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 12, 12, 0]).map_err(|e| format!("{e} | call: _mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128() -> Result<(), String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0, 6, 1, 7]).map_err(|e| format!("{e} | call: _mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_normal2() -> Result<(), String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_normal2_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[6136, 632, 23312, 0]).map_err(|e| format!("{e} | call: _mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_normal3() -> Result<(), String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_normal3_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 1073741824, 0, 1073741824]).map_err(|e| format!("{e} | call: _mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_min() -> Result<(), String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_min_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1431655765, 357913941, 1431655765, 357913941]).map_err(|e| format!("{e} | call: _mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_max() -> Result<(), String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_max_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_zero_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[1431655765, 1431655765, 1431655765, 1431655765]).map_err(|e| format!("{e} | call: _mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_allones_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 1073741824, 1431655765, 357913941]).map_err(|e| format!("{e} | call: _mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_mixed_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483648, 1073741823, -2147483648, 1073741823]).map_err(|e| format!("{e} | call: _mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_asym_min_max_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, 1073741823, -2147483648, 1073741823]).map_err(|e| format!("{e} | call: _mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_asym_max_min_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 12, 12, 0]).map_err(|e| format!("{e} | call: _mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_imm_0() -> Result<(), String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_imm_0_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[15, 30, 24, 0]).map_err(|e| format!("{e} | call: _mm_clmulepi64_si128::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_clmulepi64_si128::<1>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_imm_1() -> Result<(), String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_imm_1_impl() }
}
