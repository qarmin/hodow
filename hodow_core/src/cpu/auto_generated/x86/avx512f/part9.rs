#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtsepi64_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi32(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtsepi64_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi32(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtsepi64_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi32(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtsepi64_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi32(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtsepi64_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi32(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtsepi64_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi32(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtsepi64_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi32(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtsepi64_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[2147483647, -2147483648, 2147483647, -2147483648]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi32(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[2147483647, 2, 2147483647, 4]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[2147483647, -1, 2147483647, -3]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[2147483647, 200, 2147483647, 400]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, -1]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, -2147483648, 2147483647, -2147483648]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, 2147483647, -2147483648, 2147483647]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[2147483647, 0, 2147483647, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi32(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-2147483648, 0, -2147483648, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi32(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[2147483647, 0, 2147483647, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi32(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, 0, -2147483648, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi32(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 0, 2147483647, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi32(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi32(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi32(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[2147483647, 0, 2147483647, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi32(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtsepi64_epi32(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[2147483647, 2147483647, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi32(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtsepi64_epi32(create__m128i_from_i32_array([0, -1, 2, -3])));
        check_array_equality(&result, &[-2147483648, -2147483648, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi32(create__m128i_from_i32_array([0, -1, 2, -3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtsepi64_epi32(create__m128i_from_i32_array([100, 200, 300, 400])));
        check_array_equality(&result, &[2147483647, 2147483647, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi32(create__m128i_from_i32_array([100, 200, 300, 400]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtsepi64_epi32(create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi32(create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtsepi64_epi32(create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[2147483647, -2147483648, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[2147483647, 2, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[2147483647, -1, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[2147483647, 200, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[2147483647, 2147483647, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, -2147483648, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[2147483647, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi32(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3])));
        check_array_equality(&result, &[-2147483648, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi32(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400])));
        check_array_equality(&result, &[2147483647, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi32(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi32(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi32(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi32(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi32(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[2147483647, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi32(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsepi64_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_cvtsepi64_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| format!("{e} | call: _mm512_cvtsepi64_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtsepi64_epi16(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtsepi64_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtsepi64_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsepi64_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_cvtsepi64_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| format!("{e} | call: _mm512_cvtsepi64_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtsepi64_epi16(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtsepi64_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtsepi64_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsepi64_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_cvtsepi64_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| format!("{e} | call: _mm512_cvtsepi64_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtsepi64_epi16(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtsepi64_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtsepi64_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsepi64_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_cvtsepi64_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| format!("{e} | call: _mm512_cvtsepi64_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtsepi64_epi16(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtsepi64_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtsepi64_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsepi64_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_cvtsepi64_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| format!("{e} | call: _mm512_cvtsepi64_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtsepi64_epi16(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtsepi64_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtsepi64_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsepi64_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_cvtsepi64_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_cvtsepi64_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtsepi64_epi16(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtsepi64_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtsepi64_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsepi64_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_cvtsepi64_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtsepi64_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtsepi64_epi16(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtsepi64_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtsepi64_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsepi64_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_cvtsepi64_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| format!("{e} | call: _mm512_cvtsepi64_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtsepi64_epi16(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtsepi64_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtsepi64_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_mask_cvtsepi64_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[32767, 0, 32767, 0, 32767, 0, 32767, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_mask_cvtsepi64_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[32767, -1, 32767, -3, 32767, -5, 32767, -7]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_mask_cvtsepi64_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210])));
        check_array_equality(&result, &[32767, 200, 32767, 400, 32767, 600, 32767, 800]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_mask_cvtsepi64_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_mask_cvtsepi64_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, -32768, -1, -32768, 32767, -32768, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi16_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[32767, 0, 32767, 0, 32767, 0, 32767, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-32768, 0, -32768, 0, -32768, 0, -32768, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200])));
        check_array_equality(&result, &[32767, 0, 32767, 0, 32767, 0, 32767, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 0, -32768, 0, -32768, 0, -32768, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 0, 32767, 0, 32767, 0, 32767, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm512_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 0, -32768, 0, -32768, 0, -32768, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtsepi64_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_cvtsepi64_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_cvtsepi64_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_cvtsepi64_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_cvtsepi64_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_cvtsepi64_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_cvtsepi64_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_cvtsepi64_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_cvtsepi64_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtsepi64_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[32767, 0, 32767, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtsepi64_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[32767, -1, 32767, -3, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtsepi64_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[32767, 200, 32767, 400, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtsepi64_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtsepi64_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, -32768, -1, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, -32768, 32767, -32768, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 32767, -32768, 32767, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi16_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[32767, 0, 32767, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-32768, 0, -32768, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600])));
        check_array_equality(&result, &[32767, 0, 32767, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 0, -32768, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 0, 32767, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 0, -32768, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_cvtsepi64_epi16(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[32767, 32767, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi16(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_cvtsepi64_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-32768, -32768, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_cvtsepi64_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[32767, 32767, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_cvtsepi64_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_cvtsepi64_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, -32768, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtsepi64_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[32767, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtsepi64_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[32767, -1, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtsepi64_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[32767, 200, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtsepi64_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtsepi64_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, -32768, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 32767, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi16_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[32767, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-32768, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[32767, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsepi64_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_cvtsepi64_epi8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_cvtsepi64_epi8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtsepi64_epi8(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtsepi64_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtsepi64_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsepi64_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_cvtsepi64_epi8(create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_cvtsepi64_epi8(create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtsepi64_epi8(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtsepi64_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtsepi64_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsepi64_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_cvtsepi64_epi8(create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0])));
        check_array_equality(&result, &[127, 127, 127, -128, -128, -128, -128, 127, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_cvtsepi64_epi8(create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtsepi64_epi8(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtsepi64_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtsepi64_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsepi64_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_cvtsepi64_epi8(create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_cvtsepi64_epi8(create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtsepi64_epi8(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtsepi64_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtsepi64_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsepi64_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_cvtsepi64_epi8(create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_cvtsepi64_epi8(create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtsepi64_epi8(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtsepi64_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtsepi64_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsepi64_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_cvtsepi64_epi8(create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_cvtsepi64_epi8(create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtsepi64_epi8(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtsepi64_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtsepi64_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsepi64_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_cvtsepi64_epi8(create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_cvtsepi64_epi8(create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtsepi64_epi8(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtsepi64_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtsepi64_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsepi64_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_cvtsepi64_epi8(create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_cvtsepi64_epi8(create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtsepi64_epi8(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtsepi64_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtsepi64_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtsepi64_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[127, 0, 127, 0, 127, 0, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtsepi64_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[127, -1, 127, -3, 127, -5, 127, -7, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtsepi64_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask8_from(0b01010101), create__m512i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118, -18, 82, -74, 26, 126, -30, 70, -86, 14, 114, -42, 58, -98, 2, 102, -54, 46, -110, -10, 90, -66, 34, -122, -22, 78, -78, 22, 122, -34, 66, -90, 10])));
        check_array_equality(&result, &[127, -56, 127, -112, -128, 88, -128, 32, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask8_from(0b01010101), create__m512i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118, -18, 82, -74, 26, 126, -30, 70, -86, 14, 114, -42, 58, -98, 2, 102, -54, 46, -110, -10, 90, -66, 34, -122, -22, 78, -78, 22, 122, -34, 66, -90, 10]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtsepi64_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtsepi64_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 127, -128, -1, -128, 127, -128, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, -128, 127, -128, 127, -128, 127, -128, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, 127, -128, 127, -128, 127, -128, 127, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_epi8_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[127, 0, 127, 0, 127, 0, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-128, 0, -128, 0, -128, 0, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0])));
        check_array_equality(&result, &[127, 0, 127, 0, -128, 0, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, 0, -128, 0, -128, 0, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 0, 127, 0, 127, 0, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 0, -128, 0, -128, 0, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtsepi64_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_cvtsepi64_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[127, 127, 127, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_cvtsepi64_epi8(create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-128, -128, -128, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi8(create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_cvtsepi64_epi8(create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128])));
        check_array_equality(&result, &[127, 127, 127, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi8(create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_cvtsepi64_epi8(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi8(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_cvtsepi64_epi8(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi8(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_cvtsepi64_epi8(create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi8(create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_cvtsepi64_epi8(create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi8(create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtsepi64_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_cvtsepi64_epi8(create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, -128, -128, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtsepi64_epi8(create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsepi64_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtsepi64_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtsepi64_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtsepi64_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[127, 0, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtsepi64_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[127, -1, 127, -3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtsepi64_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118])));
        check_array_equality(&result, &[127, -56, 127, -112, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtsepi64_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtsepi64_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 127, -128, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, -128, 127, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, 127, -128, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_epi8_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[127, 0, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-128, 0, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128])));
        check_array_equality(&result, &[127, 0, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, 0, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 0, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 0, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtsepi64_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtsepi64_epi8(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[127, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi8(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtsepi64_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-128, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtsepi64_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64])));
        check_array_equality(&result, &[127, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtsepi64_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtsepi64_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtsepi64_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi64_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtsepi64_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtsepi64_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi64_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi64_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[127, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi64_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74])));
        check_array_equality(&result, &[127, -56, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi64_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi64_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi64_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi64_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_epi8_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64])));
        check_array_equality(&result, &[127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtsepi64_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi64_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi64_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtsepi64_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtsepi64_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi32_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_cvtusepi32_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: _mm512_cvtusepi32_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi32_epi16(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi32_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi32_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi32_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_cvtusepi32_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi32_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi32_epi16(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi32_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi32_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi32_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_cvtusepi32_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi32_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi32_epi16(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi32_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi32_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi32_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_cvtusepi32_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi32_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi32_epi16(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi32_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi32_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi32_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_cvtusepi32_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi32_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi32_epi16(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi32_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi32_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi32_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_cvtusepi32_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_cvtusepi32_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi32_epi16(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi32_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi32_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi32_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_cvtusepi32_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi32_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi32_epi16(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi32_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi32_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi32_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_cvtusepi32_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi32_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi32_epi16(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi32_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi32_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_mask_cvtusepi32_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 0, 11, 0, 13, 0, 15, 0, 17, 0, 19, 0, 21, 0, 23, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi16(create_random__m256i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_mask_cvtusepi32_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-1, -1, -1, -3, -1, -5, -1, -7, -1, -1, -1, -3, -1, -5, -1, -7]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi16(create_random__m256i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_mask_cvtusepi32_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210])));
        check_array_equality(&result, &[-1, 200, -1, 400, -1, 600, -1, 800, -1, 1000, -1, 1200, -1, 1400, -1, 1600]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi16(create_random__m256i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_mask_cvtusepi32_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi16(create_random__m256i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_mask_cvtusepi32_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, 32767, -1, 32767, -1, 32767, -1, 32767, -1, 32767, -1, 32767, -1, 32767, -1, 32767]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi16(create_random__m256i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_mask_cvtusepi32_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi16(create_random__m256i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_mask_cvtusepi32_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi16(create_random__m256i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_mask_cvtusepi32_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 32767, -1, -1, -1, 32767, -1, -1, -1, 32767, -1, -1, -1, 32767, -1, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi16(create_random__m256i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_mask_cvtusepi32_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi16(create_random__m256i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_mask_cvtusepi32_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, 32767, -1, 32767, -1, 32767, -1, 32767, -1, 32767, -1, 32767, -1, 32767, -1, 32767]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi16(create_random__m256i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi16_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_maskz_cvtusepi32_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0, 9, 0, 11, 0, 13, 0, 15, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi32_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi32_epi16(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_maskz_cvtusepi32_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi32_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi32_epi16(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_maskz_cvtusepi32_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi32_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi32_epi16(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_maskz_cvtusepi32_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi32_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi32_epi16(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_maskz_cvtusepi32_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi32_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi32_epi16(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_maskz_cvtusepi32_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi32_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi32_epi16(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_maskz_cvtusepi32_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi32_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi32_epi16(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm512_maskz_cvtusepi32_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi32_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi32_epi16(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi32_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi32_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_cvtusepi32_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm256_cvtusepi32_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi32_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi32_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi32_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi32_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_cvtusepi32_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_cvtusepi32_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi32_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi32_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi32_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi32_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_cvtusepi32_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_cvtusepi32_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi32_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi32_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi32_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi32_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_cvtusepi32_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_cvtusepi32_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi32_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi32_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi32_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi32_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_cvtusepi32_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_cvtusepi32_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi32_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi32_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi32_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi32_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_cvtusepi32_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_cvtusepi32_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi32_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi32_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi32_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi32_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_cvtusepi32_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_cvtusepi32_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi32_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi32_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi32_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi32_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_cvtusepi32_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_cvtusepi32_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi32_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi32_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi32_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtusepi32_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[5, 0, 7, 0, 9, 0, 11, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtusepi32_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-1, -1, -1, -3, -1, -5, -1, -7]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtusepi32_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[-1, 200, -1, 400, -1, 600, -1, 800]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -32768, -1, -32768, -1, -32768, -1, -32768]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, 32767, -1, 32767, -1, 32767, -1, 32767]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtusepi32_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtusepi32_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 32767, -1, -1, -1, 32767, -1, -1]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, -32768, -1, -32768, -1, -32768, -1, -32768]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, 32767, -1, 32767, -1, 32767, -1, 32767]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi16_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi32_epi16(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi32_epi16(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi32_epi16(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi32_epi16(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi32_epi16(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi32_epi16(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi32_epi16(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm256_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi32_epi16(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi32_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi32_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_cvtusepi32_epi16(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi32_epi16(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi32_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi32_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi32_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi32_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_cvtusepi32_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi32_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi32_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi32_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi32_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi32_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_cvtusepi32_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi32_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi32_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi32_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi32_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi32_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi32_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi32_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi32_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi32_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi32_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi32_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi32_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi32_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_cvtusepi32_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_cvtusepi32_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi32_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi32_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi32_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi32_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_cvtusepi32_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi32_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi32_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi32_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi32_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi32_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi32_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi32_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi32_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtusepi32_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 7, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtusepi32_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-1, -1, -1, -3, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtusepi32_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[-1, 200, -1, 400, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -32768, -1, -32768, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, 32767, -1, 32767, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtusepi32_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtusepi32_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 32767, -1, -1, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, -32768, -1, -32768, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, 32767, -1, 32767, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi16_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtusepi32_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 3, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi32_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtusepi32_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtusepi32_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtusepi32_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-1, 0, -1, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi32_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtusepi32_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtusepi32_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtusepi32_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[-1, 0, -1, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi32_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtusepi32_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtusepi32_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtusepi32_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi32_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtusepi32_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtusepi32_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtusepi32_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi32_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtusepi32_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtusepi32_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtusepi32_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi32_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtusepi32_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtusepi32_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtusepi32_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi32_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtusepi32_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtusepi32_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtusepi32_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi32_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi32_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtusepi32_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtusepi32_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi32_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_cvtusepi32_epi8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: _mm512_cvtusepi32_epi8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi32_epi8(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi32_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi32_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi32_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_cvtusepi32_epi8(create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi32_epi8(create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi32_epi8(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi32_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi32_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi32_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_cvtusepi32_epi8(create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi32_epi8(create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi32_epi8(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi32_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi32_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi32_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_cvtusepi32_epi8(create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi32_epi8(create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi32_epi8(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi32_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi32_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi32_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_cvtusepi32_epi8(create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi32_epi8(create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi32_epi8(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi32_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi32_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi32_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_cvtusepi32_epi8(create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_cvtusepi32_epi8(create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi32_epi8(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi32_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi32_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi32_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_cvtusepi32_epi8(create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi32_epi8(create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi32_epi8(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi32_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi32_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi32_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_cvtusepi32_epi8(create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi32_epi8(create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi32_epi8(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi32_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi32_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtusepi32_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[5, 0, 7, 0, 9, 0, 11, 0, 13, 0, 15, 0, 17, 0, 19, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtusepi32_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-1, -1, -1, -3, -1, -5, -1, -7, -1, -1, -1, -3, -1, -5, -1, -7]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtusepi32_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118, -18, 82, -74, 26, 126, -30, 70, -86, 14, 114, -42, 58, -98, 2, 102, -54, 46, -110, -10, 90, -66, 34, -122, -22, 78, -78, 22, 122, -34, 66, -90, 10])));
        check_array_equality(&result, &[-1, -56, -1, -112, -1, 88, -1, 32, -1, -24, -1, -80, -1, 120, -1, 64]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118, -18, 82, -74, 26, 126, -30, 70, -86, 14, 114, -42, 58, -98, 2, 102, -54, 46, -110, -10, 90, -66, 34, -122, -22, 78, -78, 22, 122, -34, 66, -90, 10]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtusepi32_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtusepi32_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 127, -1, -1, -1, 127, -1, -1, -1, 127, -1, -1, -1, 127, -1, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_epi8_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_maskz_cvtusepi32_epi8(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0, 9, 0, 11, 0, 13, 0, 15, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi32_epi8(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi32_epi8(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_maskz_cvtusepi32_epi8(create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi32_epi8(create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi32_epi8(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_maskz_cvtusepi32_epi8(create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi32_epi8(create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi32_epi8(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_maskz_cvtusepi32_epi8(create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi32_epi8(create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi32_epi8(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_maskz_cvtusepi32_epi8(create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi32_epi8(create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi32_epi8(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_maskz_cvtusepi32_epi8(create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi32_epi8(create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi32_epi8(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_maskz_cvtusepi32_epi8(create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi32_epi8(create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi32_epi8(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm512_maskz_cvtusepi32_epi8(create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi32_epi8(create__mmask16_from(0b0101010101010101), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi32_epi8(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi32_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi32_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_cvtusepi32_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtusepi32_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi32_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi32_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi32_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi32_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_cvtusepi32_epi8(create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtusepi32_epi8(create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi32_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi32_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi32_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi32_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_cvtusepi32_epi8(create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtusepi32_epi8(create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi32_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi32_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi32_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi32_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_cvtusepi32_epi8(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtusepi32_epi8(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi32_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi32_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi32_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi32_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_cvtusepi32_epi8(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtusepi32_epi8(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi32_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi32_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi32_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi32_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_cvtusepi32_epi8(create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_cvtusepi32_epi8(create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi32_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi32_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi32_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi32_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_cvtusepi32_epi8(create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtusepi32_epi8(create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi32_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi32_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi32_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi32_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_cvtusepi32_epi8(create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_cvtusepi32_epi8(create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi32_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi32_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi32_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtusepi32_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[5, 0, 7, 0, 9, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtusepi32_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-1, -1, -1, -3, -1, -5, -1, -7, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtusepi32_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118])));
        check_array_equality(&result, &[-1, -56, -1, -112, -1, 88, -1, 32, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -128, -1, -128, -1, -128, -1, -128, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, 127, -1, 127, -1, 127, -1, 127, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtusepi32_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtusepi32_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 127, -1, -1, -1, 127, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, -128, -1, -128, -1, -128, -1, -128, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, 127, -1, 127, -1, 127, -1, 127, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_epi8_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi32_epi8(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi32_epi8(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi32_epi8(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi32_epi8(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi32_epi8(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi32_epi8(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi32_epi8(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm256_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi32_epi8(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi32_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi32_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtusepi32_epi8(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi32_epi8(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi32_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi32_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi32_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi32_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtusepi32_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi32_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi32_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi32_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi32_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi32_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtusepi32_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi32_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi32_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi32_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi32_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi32_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi32_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi32_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi32_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi32_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi32_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi32_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi32_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi32_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtusepi32_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_cvtusepi32_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi32_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi32_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi32_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi32_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtusepi32_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi32_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi32_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi32_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi32_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi32_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi32_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi32_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi32_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi32_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi32_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-1, -1, -1, -3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi32_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74])));
        check_array_equality(&result, &[-1, -56, -1, -112, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -128, -1, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, 127, -1, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi32_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi32_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 127, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, -128, -1, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, 127, -1, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi32_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi32_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_epi8_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtusepi32_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi32_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtusepi32_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtusepi32_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtusepi32_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi32_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtusepi32_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtusepi32_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtusepi32_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64])));
        check_array_equality(&result, &[-1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi32_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtusepi32_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtusepi32_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtusepi32_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi32_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtusepi32_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtusepi32_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtusepi32_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi32_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtusepi32_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtusepi32_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtusepi32_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi32_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtusepi32_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtusepi32_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtusepi32_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi32_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtusepi32_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtusepi32_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtusepi32_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi32_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi32_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtusepi32_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtusepi32_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi64_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_cvtusepi64_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi64_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi64_epi32(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi64_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi64_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi64_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_cvtusepi64_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi64_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi64_epi32(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi64_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi64_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi64_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_cvtusepi64_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi64_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi64_epi32(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi64_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi64_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi64_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_cvtusepi64_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi64_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi64_epi32(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi64_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi64_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi64_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_cvtusepi64_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi64_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi64_epi32(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi64_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi64_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi64_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_cvtusepi64_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_cvtusepi64_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi64_epi32(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi64_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi64_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi64_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_cvtusepi64_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi64_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi64_epi32(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi64_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi64_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtusepi64_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_cvtusepi64_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_cvtusepi64_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtusepi64_epi32(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtusepi64_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtusepi64_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-1, 2, -1, 4, -1, 6, -1, 8]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi64_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-1, -1, -1, -3, -1, -5, -1, -7]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi64_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[-1, 200, -1, 400, -1, 600, -1, 800]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi64_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, -2147483648, -1, -2147483648, -1, -2147483648, -1, -2147483648]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi64_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, 2147483647, -1, 2147483647, -1, 2147483647, -1, 2147483647]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi64_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi64_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi64_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 2147483647, -1, -1, -1, 2147483647, -1, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi64_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, -2147483648, -1, -2147483648, -1, -2147483648, -1, -2147483648]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi64_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, 2147483647, -1, 2147483647, -1, 2147483647, -1, 2147483647]).map_err(|e| format!("{e} | call: _mm512_mask_cvtusepi64_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtusepi64_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi64_epi32(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi64_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi64_epi32(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi64_epi32(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi64_epi32(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi64_epi32(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi64_epi32(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi64_epi32(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtusepi64_epi32(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtusepi64_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi64_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtusepi64_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_cvtusepi64_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi64_epi32(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi64_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi64_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi64_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtusepi64_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_cvtusepi64_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi64_epi32(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi64_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi64_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi64_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtusepi64_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_cvtusepi64_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi64_epi32(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi64_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi64_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi64_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtusepi64_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_cvtusepi64_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi64_epi32(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi64_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi64_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi64_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtusepi64_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_cvtusepi64_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi64_epi32(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi64_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi64_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi64_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtusepi64_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_cvtusepi64_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi64_epi32(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi64_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi64_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi64_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtusepi64_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_cvtusepi64_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi64_epi32(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi64_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi64_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtusepi64_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtusepi64_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_cvtusepi64_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtusepi64_epi32(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtusepi64_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtusepi64_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[-1, 2, -1, 4]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-1, -1, -1, -3]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[-1, 200, -1, 400]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, -2147483648, -1, -2147483648]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, 2147483647, -1, 2147483647]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 2147483647, -1, -1]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, -2147483648, -1, -2147483648]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, 2147483647, -1, 2147483647]).map_err(|e| format!("{e} | call: _mm256_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi64_epi32(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi64_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi64_epi32(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi64_epi32(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi64_epi32(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi64_epi32(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi64_epi32(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi64_epi32(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtusepi64_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtusepi64_epi32(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtusepi64_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi64_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtusepi64_epi32(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[-1, -1, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi64_epi32(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi64_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi64_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi64_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi64_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtusepi64_epi32(create__m128i_from_i32_array([0, -1, 2, -3])));
        check_array_equality(&result, &[-1, -1, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi64_epi32(create__m128i_from_i32_array([0, -1, 2, -3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi64_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi64_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi64_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi64_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtusepi64_epi32(create__m128i_from_i32_array([100, 200, 300, 400])));
        check_array_equality(&result, &[-1, -1, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi64_epi32(create__m128i_from_i32_array([100, 200, 300, 400]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi64_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi64_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi64_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi64_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, -1, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi64_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi64_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi64_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi64_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, -1, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi64_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi64_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi64_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi64_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtusepi64_epi32(create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_cvtusepi64_epi32(create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi64_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi64_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi64_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi64_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtusepi64_epi32(create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi64_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi64_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi64_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi64_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtusepi64_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1, -1, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi64_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtusepi64_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtusepi64_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[-1, 2, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[-1, -1, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[-1, 200, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, -2147483648, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, 2147483647, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 2147483647, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, -2147483648, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, 2147483647, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi64_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi64_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_epi32_asym_max_min_impl() }
}
