#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvttpd_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttpd_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128d_from([5.0, 6.0])));
        check_array_equality(&result, &[5, 2, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvttpd_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvttpd_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvttpd_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvttpd_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttpd_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, -1, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvttpd_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvttpd_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvttpd_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvttpd_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttpd_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 200, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvttpd_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvttpd_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvttpd_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvttpd_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttpd_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, -2147483648, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvttpd_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvttpd_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvttpd_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvttpd_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttpd_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2147483647, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvttpd_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvttpd_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvttpd_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvttpd_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttpd_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvttpd_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvttpd_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvttpd_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvttpd_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttpd_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, -1, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvttpd_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvttpd_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvttpd_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvttpd_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttpd_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2147483647, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvttpd_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvttpd_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvttpd_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvttpd_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvttpd_epi32(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvttpd_epi32(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvttpd_epi32(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvttpd_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvttpd_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvttpd_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_cvttpd_epu32(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm512_cvttpd_epu32(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvttpd_epu32(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvttpd_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvttpd_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvttpd_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_mask_cvttpd_epu32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[9, 2, 11, 4, 13, 6, 15, 8]).map_err(|e| format!("{e} | call: _mm512_mask_cvttpd_epu32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvttpd_epu32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvttpd_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvttpd_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvttpd_epu32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_mask_cvttpd_epu32(create__m256i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967293, 5, 4294967291, 7, 4294967289]).map_err(|e| format!("{e} | call: _mm512_mask_cvttpd_epu32(create__m256i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvttpd_epu32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvttpd_epu32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvttpd_epu32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvttpd_epu32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_mask_cvttpd_epu32(create__m256i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800]).map_err(|e| format!("{e} | call: _mm512_mask_cvttpd_epu32(create__m256i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvttpd_epu32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvttpd_epu32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvttpd_epu32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvttpd_epu32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_mask_cvttpd_epu32(create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvttpd_epu32(create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvttpd_epu32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvttpd_epu32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvttpd_epu32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvttpd_epu32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_mask_cvttpd_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295, 5, 4294967295, 7, 4294967295]).map_err(|e| format!("{e} | call: _mm512_mask_cvttpd_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvttpd_epu32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvttpd_epu32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvttpd_epu32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvttpd_epu32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_mask_cvttpd_epu32(create__m256i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvttpd_epu32(create__m256i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvttpd_epu32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvttpd_epu32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvttpd_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvttpd_epu32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_mask_cvttpd_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295, 5, 4294967295, 7, 4294967295]).map_err(|e| format!("{e} | call: _mm512_mask_cvttpd_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvttpd_epu32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvttpd_epu32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvttpd_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvttpd_epu32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_mask_cvttpd_epu32(create__m256i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295, 5, 4294967295, 7, 4294967295]).map_err(|e| format!("{e} | call: _mm512_mask_cvttpd_epu32(create__m256i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvttpd_epu32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvttpd_epu32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvttpd_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvttpd_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_maskz_cvttpd_epu32(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvttpd_epu32(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvttpd_epu32(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvttpd_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvttpd_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvttpd_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_cvttpd_epu32(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: _mm256_cvttpd_epu32(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvttpd_epu32(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvttpd_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvttpd_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvttpd_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_mask_cvttpd_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[5, 2, 7, 4]).map_err(|e| format!("{e} | call: _mm256_mask_cvttpd_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvttpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvttpd_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvttpd_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvttpd_epu32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_mask_cvttpd_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967293]).map_err(|e| format!("{e} | call: _mm256_mask_cvttpd_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvttpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvttpd_epu32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvttpd_epu32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvttpd_epu32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_mask_cvttpd_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 200, 3, 400]).map_err(|e| format!("{e} | call: _mm256_mask_cvttpd_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvttpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvttpd_epu32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvttpd_epu32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvttpd_epu32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_mask_cvttpd_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvttpd_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvttpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvttpd_epu32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvttpd_epu32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvttpd_epu32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_mask_cvttpd_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295]).map_err(|e| format!("{e} | call: _mm256_mask_cvttpd_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvttpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvttpd_epu32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvttpd_epu32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvttpd_epu32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_mask_cvttpd_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvttpd_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvttpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvttpd_epu32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvttpd_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvttpd_epu32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_mask_cvttpd_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295]).map_err(|e| format!("{e} | call: _mm256_mask_cvttpd_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvttpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvttpd_epu32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvttpd_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvttpd_epu32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_mask_cvttpd_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295]).map_err(|e| format!("{e} | call: _mm256_mask_cvttpd_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvttpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvttpd_epu32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvttpd_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvttpd_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_maskz_cvttpd_epu32(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvttpd_epu32(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvttpd_epu32(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvttpd_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvttpd_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvttpd_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_cvttpd_epu32(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvttpd_epu32(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttpd_epu32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvttpd_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvttpd_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvttpd_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvttpd_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128d_from([5.0, 6.0])));
        check_array_equality(&result, &[5, 2, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvttpd_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvttpd_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvttpd_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvttpd_epu32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvttpd_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 4294967295, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvttpd_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvttpd_epu32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvttpd_epu32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvttpd_epu32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvttpd_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 200, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvttpd_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvttpd_epu32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvttpd_epu32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvttpd_epu32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvttpd_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvttpd_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvttpd_epu32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvttpd_epu32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvttpd_epu32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvttpd_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 4294967295, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvttpd_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvttpd_epu32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvttpd_epu32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvttpd_epu32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvttpd_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvttpd_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvttpd_epu32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvttpd_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvttpd_epu32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvttpd_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 4294967295, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvttpd_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvttpd_epu32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvttpd_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvttpd_epu32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvttpd_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 4294967295, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvttpd_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvttpd_epu32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvttpd_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvttpd_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_maskz_cvttpd_epu32(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvttpd_epu32(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvttpd_epu32(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvttpd_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvttpd_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i32gather_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let result = unpack__m512d_to_f64_array(_mm512_i32gather_pd::<1>(offsets, ptr_slice.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: _mm512_i32gather_pd::<1>(offsets, ptr_slice.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i32gather_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i32gather_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i32gather_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let result = unpack__m512d_to_f64_array(_mm512_mask_i32gather_pd::<1>(src, mask, offsets, ptr_slice.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 2.0, 1.0, 4.0, 1.0, 6.0, 1.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_i32gather_pd::<1>(src, mask, offsets, ptr_slice.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i32gather_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i32gather_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i64gather_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let result = unpack__m512d_to_f64_array(_mm512_i64gather_pd::<1>(offsets, ptr_slice.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: _mm512_i64gather_pd::<1>(offsets, ptr_slice.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i64gather_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i64gather_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i64gather_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let result = unpack__m512d_to_f64_array(_mm512_mask_i64gather_pd::<1>(src, mask, offsets, ptr_slice.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 2.0, 1.0, 4.0, 1.0, 6.0, 1.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_i64gather_pd::<1>(src, mask, offsets, ptr_slice.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i64gather_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i64gather_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i64gather_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let result = unpack__m256_to_f32_array(_mm512_i64gather_ps::<1>(offsets, ptr_slice.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: _mm512_i64gather_ps::<1>(offsets, ptr_slice.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i64gather_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i64gather_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i64gather_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let result = unpack__m256_to_f32_array(_mm512_mask_i64gather_ps::<1>(src, mask, offsets, ptr_slice.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 2.0, 1.0, 4.0, 1.0, 6.0, 1.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_i64gather_ps::<1>(src, mask, offsets, ptr_slice.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i64gather_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i64gather_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i32gather_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let result = unpack__m512_to_f32_array(_mm512_i32gather_ps::<1>(offsets, ptr_slice.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: _mm512_i32gather_ps::<1>(offsets, ptr_slice.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i32gather_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i32gather_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i32gather_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]);
        let mask = create__mmask16_from(0b0101010101010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let result = unpack__m512_to_f32_array(_mm512_mask_i32gather_ps::<1>(src, mask, offsets, ptr_slice.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 2.0, 1.0, 4.0, 1.0, 6.0, 1.0, 8.0, 1.0, 10.0, 1.0, 12.0, 1.0, 14.0, 1.0, 16.0]).map_err(|e| format!("{e} | call: _mm512_mask_i32gather_ps::<1>(src, mask, offsets, ptr_slice.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i32gather_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i32gather_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i32gather_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let result = unpack__m512i_to_i32_array(_mm512_i32gather_epi32::<1>(offsets, ptr_slice.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: _mm512_i32gather_epi32::<1>(offsets, ptr_slice.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i32gather_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i32gather_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i32gather_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__mmask16_from(0b0101010101010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let result = unpack__m512i_to_i32_array(_mm512_mask_i32gather_epi32::<1>(src, mask, offsets, ptr_slice.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| format!("{e} | call: _mm512_mask_i32gather_epi32::<1>(src, mask, offsets, ptr_slice.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i32gather_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i32gather_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i32gather_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let result = unpack__m512i_to_i32_array(_mm512_i32gather_epi64::<1>(offsets, ptr_slice.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| format!("{e} | call: _mm512_i32gather_epi64::<1>(offsets, ptr_slice.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i32gather_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i32gather_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i32gather_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let result = unpack__m512i_to_i32_array(_mm512_mask_i32gather_epi64::<1>(src, mask, offsets, ptr_slice.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_mask_i32gather_epi64::<1>(src, mask, offsets, ptr_slice.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i32gather_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i32gather_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i64gather_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let result = unpack__m512i_to_i32_array(_mm512_i64gather_epi64::<1>(offsets, ptr_slice.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| format!("{e} | call: _mm512_i64gather_epi64::<1>(offsets, ptr_slice.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i64gather_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i64gather_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i64gather_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let result = unpack__m512i_to_i32_array(_mm512_mask_i64gather_epi64::<1>(src, mask, offsets, ptr_slice.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_mask_i64gather_epi64::<1>(src, mask, offsets, ptr_slice.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i64gather_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i64gather_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i64gather_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let result = unpack__m256i_to_i32_array(_mm512_i64gather_epi32::<1>(offsets, ptr_slice.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: _mm512_i64gather_epi32::<1>(offsets, ptr_slice.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i64gather_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i64gather_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i64gather_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let result = unpack__m256i_to_i32_array(_mm512_mask_i64gather_epi32::<1>(src, mask, offsets, ptr_slice.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| format!("{e} | call: _mm512_mask_i64gather_epi32::<1>(src, mask, offsets, ptr_slice.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i64gather_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i64gather_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i32scatter_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_i32scatter_pd::<1>(ptr_slice.0.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i32scatter_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i32scatter_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i32scatter_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_mask_i32scatter_pd::<1>(ptr_slice.0.as_mut_ptr(), mask, offsets, src);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i32scatter_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i32scatter_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i64scatter_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_i64scatter_pd::<1>(ptr_slice.0.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i64scatter_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i64scatter_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i64scatter_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_mask_i64scatter_pd::<1>(ptr_slice.0.as_mut_ptr(), mask, offsets, src);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i64scatter_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i64scatter_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i32scatter_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]);
        _mm512_i32scatter_ps::<1>(ptr_slice.0.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i32scatter_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i32scatter_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i32scatter_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let mask = create__mmask16_from(0b0101010101010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]);
        _mm512_mask_i32scatter_ps::<1>(ptr_slice.0.as_mut_ptr(), mask, offsets, src);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i32scatter_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i32scatter_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i64scatter_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_i64scatter_ps::<1>(ptr_slice.0.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i64scatter_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i64scatter_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i64scatter_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_mask_i64scatter_ps::<1>(ptr_slice.0.as_mut_ptr(), mask, offsets, src);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i64scatter_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i64scatter_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i32scatter_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_i32scatter_epi64::<1>(ptr_slice.0.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i32scatter_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i32scatter_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i32scatter_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_i32scatter_epi64::<1>(ptr_slice.0.as_mut_ptr(), mask, offsets, src);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i32scatter_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i32scatter_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i64scatter_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_i64scatter_epi64::<1>(ptr_slice.0.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i64scatter_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i64scatter_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i64scatter_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_i64scatter_epi64::<1>(ptr_slice.0.as_mut_ptr(), mask, offsets, src);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i64scatter_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i64scatter_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i32scatter_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_i32scatter_epi32::<1>(ptr_slice.0.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i32scatter_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i32scatter_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i32scatter_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let mask = create__mmask16_from(0b0101010101010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_i32scatter_epi32::<1>(ptr_slice.0.as_mut_ptr(), mask, offsets, src);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i32scatter_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i32scatter_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i64scatter_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_i64scatter_epi32::<1>(ptr_slice.0.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i64scatter_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i64scatter_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i64scatter_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_i64scatter_epi32::<1>(ptr_slice.0.as_mut_ptr(), mask, offsets, src);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i64scatter_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i64scatter_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i32logather_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let vindex = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let result = unpack__m512i_to_i32_array(_mm512_i32logather_epi64::<1>(vindex, ptr_base_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| format!("{e} | call: _mm512_i32logather_epi64::<1>(vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i32logather_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i32logather_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i32logather_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let result = unpack__m512i_to_i32_array(_mm512_mask_i32logather_epi64::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_mask_i32logather_epi64::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i32logather_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i32logather_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i32logather_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let vindex = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let result = unpack__m512d_to_f64_array(_mm512_i32logather_pd::<1>(vindex, ptr_base_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: _mm512_i32logather_pd::<1>(vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i32logather_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i32logather_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i32logather_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let result = unpack__m512d_to_f64_array(_mm512_mask_i32logather_pd::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 2.0, 1.0, 4.0, 1.0, 6.0, 1.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_i32logather_pd::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i32logather_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i32logather_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i32loscatter_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let vindex = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_i32loscatter_epi64::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i32loscatter_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i32loscatter_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i32loscatter_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_i32loscatter_epi64::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_i32loscatter_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_i32loscatter_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i32loscatter_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let vindex = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_i32loscatter_pd::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_i32loscatter_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_i32loscatter_pd_impl() }
}
