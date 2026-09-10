#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_cvtne2ps_pbh(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_cvtne2ps_pbh(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_cvtne2ps_pbh(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_cvtne2ps_pbh(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_cvtne2ps_pbh(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_cvtne2ps_pbh(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_cvtne2ps_pbh(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_cvtne2ps_pbh(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_cvtne2ps_pbh(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_cvtne2ps_pbh(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([9.0, 10.0, 11.0, 12.0]), create__m128_from([13.0, 14.0, 15.0, 16.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_cvtne2ps_pbh(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_cvtne2ps_pbh(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_cvtne2ps_pbh(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_cvtne2ps_pbh(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_cvtne2ps_pbh(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_cvtne2ps_pbh(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_cvtne2ps_pbh(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_cvtne2ps_pbh(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_cvtne2ps_pbh(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_cvtne2ps_pbh(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]), create__m256_from([25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_cvtne2ps_pbh(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_cvtne2ps_pbh(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_cvtne2ps_pbh(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_cvtne2ps_pbh(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_cvtne2ps_pbh(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_cvtne2ps_pbh(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_cvtne2ps_pbh(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_cvtne2ps_pbh(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_cvtne2ps_pbh(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_cvtne2ps_pbh(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0]), create__m512_from([49.0, 50.0, 51.0, 52.0, 53.0, 54.0, 55.0, 56.0, 57.0, 58.0, 59.0, 60.0, 61.0, 62.0, 63.0, 64.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtneps_pbh_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_cvtneps_pbh(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtneps_pbh(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtneps_pbh() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtneps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtneps_pbh_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_cvtneps_pbh(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtneps_pbh(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtneps_pbh_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtneps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtneps_pbh_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_cvtneps_pbh(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtneps_pbh(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtneps_pbh_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtneps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_cvtneps_pbh(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtneps_pbh(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_cvtneps_pbh(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtneps_pbh(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_cvtneps_pbh(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtneps_pbh(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_cvtneps_pbh(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtneps_pbh(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_cvtneps_pbh(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtneps_pbh(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtneps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtneps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtneps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtneps_pbh_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_cvtneps_pbh(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtneps_pbh(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtneps_pbh() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtneps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtneps_pbh_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_cvtneps_pbh(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtneps_pbh(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtneps_pbh_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtneps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtneps_pbh_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_cvtneps_pbh(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtneps_pbh(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtneps_pbh_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtneps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_cvtneps_pbh(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtneps_pbh(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_cvtneps_pbh(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtneps_pbh(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_cvtneps_pbh(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtneps_pbh(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_cvtneps_pbh(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtneps_pbh(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_cvtneps_pbh(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtneps_pbh(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtneps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtneps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtneps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtneps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtneps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtneps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtneps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtneps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtneps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtneps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtneps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtneps_pbh(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtneps_pbh(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtneps_pbh(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtneps_pbh(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtneps_pbh(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtneps_pbh(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtneps_pbh(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtneps_pbh(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_dpbf16_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dpbf16_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]), create__m128bh_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_dpbf16_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]), create__m128bh_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dpbf16_ps(create_random__m128(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_dpbf16_ps() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_dpbf16_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_dpbf16_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dpbf16_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_dpbf16_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dpbf16_ps(create_random__m128(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_dpbf16_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_dpbf16_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_dpbf16_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dpbf16_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_dpbf16_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dpbf16_ps(create_random__m128(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_dpbf16_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_dpbf16_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dpbf16_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_dpbf16_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dpbf16_ps(create_random__m128(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_dpbf16_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dpbf16_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_dpbf16_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dpbf16_ps(create_random__m128(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_dpbf16_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dpbf16_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_dpbf16_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dpbf16_ps(create_random__m128(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_dpbf16_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dpbf16_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_dpbf16_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dpbf16_ps(create_random__m128(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_dpbf16_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dpbf16_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_dpbf16_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dpbf16_ps(create_random__m128(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_dpbf16_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_dpbf16_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_dpbf16_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]), create__m128bh_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_mask_dpbf16_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]), create__m128bh_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dpbf16_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_dpbf16_ps() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_dpbf16_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_dpbf16_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_dpbf16_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_mask_dpbf16_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dpbf16_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_dpbf16_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_dpbf16_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_dpbf16_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_dpbf16_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_mask_dpbf16_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dpbf16_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_dpbf16_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_dpbf16_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_dpbf16_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_dpbf16_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dpbf16_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_dpbf16_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_dpbf16_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dpbf16_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_dpbf16_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_mask_dpbf16_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dpbf16_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_dpbf16_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_mask_dpbf16_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dpbf16_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_dpbf16_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_mask_dpbf16_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dpbf16_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]), create__m128bh_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]), create__m128bh_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dpbf16_ps(create_random__mmask8(), create_random__m128(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_dpbf16_ps() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_dpbf16_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0, 0.0, 2.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dpbf16_ps(create_random__mmask8(), create_random__m128(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_dpbf16_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[100.0, 0.0, 300.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dpbf16_ps(create_random__mmask8(), create_random__m128(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_dpbf16_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[-3.4028235e38, 0.0, -3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dpbf16_ps(create_random__mmask8(), create_random__m128(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[3.4028235e38, 0.0, 3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dpbf16_ps(create_random__mmask8(), create_random__m128(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dpbf16_ps(create_random__mmask8(), create_random__m128(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dpbf16_ps(create_random__mmask8(), create_random__m128(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dpbf16_ps(create_random__mmask8(), create_random__m128(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_dpbf16_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dpbf16_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256bh_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create__m256bh_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm256_dpbf16_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256bh_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create__m256bh_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dpbf16_ps(create_random__m256(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_dpbf16_ps() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_dpbf16_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_dpbf16_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dpbf16_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| format!("{e} | call: _mm256_dpbf16_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dpbf16_ps(create_random__m256(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_dpbf16_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_dpbf16_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_dpbf16_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dpbf16_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0]).map_err(|e| format!("{e} | call: _mm256_dpbf16_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dpbf16_ps(create_random__m256(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_dpbf16_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_dpbf16_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dpbf16_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_dpbf16_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dpbf16_ps(create_random__m256(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_dpbf16_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dpbf16_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_dpbf16_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dpbf16_ps(create_random__m256(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_dpbf16_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dpbf16_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_dpbf16_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dpbf16_ps(create_random__m256(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_dpbf16_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dpbf16_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_dpbf16_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dpbf16_ps(create_random__m256(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_dpbf16_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dpbf16_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 0.0, 0.0, f32::INFINITY, -f32::INFINITY, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_dpbf16_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dpbf16_ps(create_random__m256(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_dpbf16_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_dpbf16_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256bh_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create__m256bh_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm256_mask_dpbf16_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256bh_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create__m256bh_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dpbf16_ps(create_random__m256(), create_random__mmask8(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_dpbf16_ps() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_dpbf16_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_dpbf16_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| format!("{e} | call: _mm256_mask_dpbf16_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dpbf16_ps(create_random__m256(), create_random__mmask8(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_dpbf16_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_dpbf16_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0]).map_err(|e| format!("{e} | call: _mm256_mask_dpbf16_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dpbf16_ps(create_random__m256(), create_random__mmask8(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_dpbf16_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_dpbf16_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_dpbf16_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dpbf16_ps(create_random__m256(), create_random__mmask8(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_dpbf16_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_dpbf16_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dpbf16_ps(create_random__m256(), create_random__mmask8(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_dpbf16_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_mask_dpbf16_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dpbf16_ps(create_random__m256(), create_random__mmask8(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_dpbf16_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_mask_dpbf16_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dpbf16_ps(create_random__m256(), create_random__mmask8(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_dpbf16_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_mask_dpbf16_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dpbf16_ps(create_random__m256(), create_random__mmask8(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256bh_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create__m256bh_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256bh_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create__m256bh_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dpbf16_ps(create_random__mmask8(), create_random__m256(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_dpbf16_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[0.0, 0.0, 2.0, 0.0, 4.0, 0.0, 6.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dpbf16_ps(create_random__mmask8(), create_random__m256(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_dpbf16_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[100.0, 0.0, 300.0, 0.0, 500.0, 0.0, 700.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dpbf16_ps(create_random__mmask8(), create_random__m256(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_dpbf16_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[-3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dpbf16_ps(create_random__mmask8(), create_random__m256(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dpbf16_ps(create_random__mmask8(), create_random__m256(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dpbf16_ps(create_random__mmask8(), create_random__m256(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dpbf16_ps(create_random__mmask8(), create_random__m256(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, 0.0, 0.0, f32::INFINITY, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dpbf16_ps(create_random__mmask8(), create_random__m256(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_dpbf16_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_dpbf16_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]), create__m512bh_from([49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]).map_err(|e| format!("{e} | call: _mm512_dpbf16_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]), create__m512bh_from([49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_dpbf16_ps(create_random__m512(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_dpbf16_ps() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_dpbf16_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_dpbf16_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_dpbf16_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0, 0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_dpbf16_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_dpbf16_ps(create_random__m512(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_dpbf16_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_dpbf16_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_dpbf16_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_dpbf16_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0, 1000.0, 1100.0, 1200.0, 1300.0, 1400.0, 1500.0, 1600.0]).map_err(|e| format!("{e} | call: _mm512_dpbf16_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_dpbf16_ps(create_random__m512(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_dpbf16_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_dpbf16_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_dpbf16_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_dpbf16_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_dpbf16_ps(create_random__m512(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_dpbf16_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_dpbf16_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_dpbf16_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_dpbf16_ps(create_random__m512(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_dpbf16_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_dpbf16_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_dpbf16_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_dpbf16_ps(create_random__m512(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_dpbf16_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_dpbf16_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_dpbf16_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_dpbf16_ps(create_random__m512(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_dpbf16_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_dpbf16_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 0.0, 0.0, f32::INFINITY, -f32::INFINITY, 0.0, 0.0, f32::INFINITY, -f32::INFINITY, 0.0, 0.0, f32::INFINITY, -f32::INFINITY, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_dpbf16_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_dpbf16_ps(create_random__m512(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_dpbf16_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_dpbf16_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]), create__m512bh_from([49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]).map_err(|e| format!("{e} | call: _mm512_mask_dpbf16_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]), create__m512bh_from([49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dpbf16_ps(create_random__m512(), create_random__mmask16(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_dpbf16_ps() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_dpbf16_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_dpbf16_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0, 0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_dpbf16_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dpbf16_ps(create_random__m512(), create_random__mmask16(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_dpbf16_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_dpbf16_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0, 1000.0, 1100.0, 1200.0, 1300.0, 1400.0, 1500.0, 1600.0]).map_err(|e| format!("{e} | call: _mm512_mask_dpbf16_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dpbf16_ps(create_random__m512(), create_random__mmask16(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_dpbf16_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_dpbf16_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_dpbf16_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dpbf16_ps(create_random__m512(), create_random__mmask16(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_dpbf16_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_dpbf16_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dpbf16_ps(create_random__m512(), create_random__mmask16(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_dpbf16_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_mask_dpbf16_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dpbf16_ps(create_random__m512(), create_random__mmask16(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_dpbf16_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_dpbf16_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dpbf16_ps(create_random__m512(), create_random__mmask16(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_dpbf16_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm512_mask_dpbf16_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dpbf16_ps(create_random__m512(), create_random__mmask16(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]), create__m512bh_from([49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0, 9.0, 0.0, 11.0, 0.0, 13.0, 0.0, 15.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]), create__m512bh_from([49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dpbf16_ps(create_random__mmask16(), create_random__m512(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_dpbf16_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[0.0, 0.0, 2.0, 0.0, 4.0, 0.0, 6.0, 0.0, 0.0, 0.0, 2.0, 0.0, 4.0, 0.0, 6.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dpbf16_ps(create_random__mmask16(), create_random__m512(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_dpbf16_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[100.0, 0.0, 300.0, 0.0, 500.0, 0.0, 700.0, 0.0, 900.0, 0.0, 1100.0, 0.0, 1300.0, 0.0, 1500.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dpbf16_ps(create_random__mmask16(), create_random__m512(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_dpbf16_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[-3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dpbf16_ps(create_random__mmask16(), create_random__m512(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dpbf16_ps(create_random__mmask16(), create_random__m512(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dpbf16_ps(create_random__mmask16(), create_random__m512(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dpbf16_ps(create_random__mmask16(), create_random__m512(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, 0.0, 0.0, f32::INFINITY, 0.0, 0.0, 0.0, f32::INFINITY, 0.0, 0.0, 0.0, f32::INFINITY, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dpbf16_ps(create_random__mmask16(), create_random__m512(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtpbh_ps_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_cvtpbh_ps(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_cvtpbh_ps(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtpbh_ps(create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_cvtpbh_ps() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_cvtpbh_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtpbh_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[1.561203e-39, 2.0, 1.744874e-39, 4.0, 1.928545e-39, 6.0, 2.112216e-39, 8.0, 2.295887e-39, 10.0, 2.479558e-39, 12.0, 2.66323e-39, 14.0, 2.8469e-39, 16.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpbh_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpbh_ps(create_random__m512(), create_random__mmask16(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtpbh_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_normal2_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtpbh_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[9.1835e-41, -1.0, 2.75506e-40, -3.0, 4.59177e-40, -5.0, 6.42848e-40, -7.0, 8.2652e-40, -1.0, 1.01019e-39, -3.0, 1.193861e-39, -5.0, 1.377532e-39, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpbh_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpbh_ps(create_random__m512(), create_random__mmask16(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtpbh_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_normal3_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtpbh_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[9.1835e-41, 200.0, 2.75506e-40, 400.0, 4.59177e-40, 600.0, 6.42848e-40, 800.0, 8.2652e-40, 1000.0, 1.01019e-39, 1200.0, 1.193861e-39, 1400.0, 1.377532e-39, 1600.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpbh_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpbh_ps(create_random__m512(), create_random__mmask16(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtpbh_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_min_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtpbh_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[9.1835e-41, -3.4028235e38, 2.75506e-40, -3.4028235e38, 4.59177e-40, -3.4028235e38, 6.42848e-40, -3.4028235e38, 8.2652e-40, -3.4028235e38, 1.01019e-39, -3.4028235e38, 1.193861e-39, -3.4028235e38, 1.377532e-39, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpbh_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpbh_ps(create_random__m512(), create_random__mmask16(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_max_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtpbh_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[9.1835e-41, 3.4028235e38, 2.75506e-40, 3.4028235e38, 4.59177e-40, 3.4028235e38, 6.42848e-40, 3.4028235e38, 8.2652e-40, 3.4028235e38, 1.01019e-39, 3.4028235e38, 1.193861e-39, 3.4028235e38, 1.377532e-39, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpbh_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpbh_ps(create_random__m512(), create_random__mmask16(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_zero_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtpbh_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpbh_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpbh_ps(create_random__m512(), create_random__mmask16(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_allones_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtpbh_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[9.1835e-41, f32::NAN, 2.75506e-40, f32::NAN, 4.59177e-40, f32::NAN, 6.42848e-40, f32::NAN, 8.2652e-40, f32::NAN, 1.01019e-39, f32::NAN, 1.193861e-39, f32::NAN, 1.377532e-39, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpbh_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpbh_ps(create_random__m512(), create_random__mmask16(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_mixed_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtpbh_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[9.1835e-41, -f32::INFINITY, 2.75506e-40, 5.877472e-39, 4.59177e-40, -f32::INFINITY, 6.42848e-40, 5.877472e-39, 8.2652e-40, -f32::INFINITY, 1.01019e-39, 5.877472e-39, 1.193861e-39, -f32::INFINITY, 1.377532e-39, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpbh_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpbh_ps(create_random__m512(), create_random__mmask16(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtpbh_ps_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_cvtpbh_ps(create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtpbh_ps(create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtpbh_ps(create_random__mmask16(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtpbh_ps() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtpbh_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtpbh_ps_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_cvtpbh_ps(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_cvtpbh_ps(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtpbh_ps(create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_cvtpbh_ps() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_cvtpbh_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtpbh_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8.2652e-40, 2.0, 1.01019e-39, 4.0, 1.193861e-39, 6.0, 1.377532e-39, 8.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpbh_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpbh_ps(create_random__m256(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtpbh_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_normal2_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtpbh_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, -1.0, 2.75506e-40, -3.0, 4.59177e-40, -5.0, 6.42848e-40, -7.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpbh_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpbh_ps(create_random__m256(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtpbh_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_normal3_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtpbh_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, 200.0, 2.75506e-40, 400.0, 4.59177e-40, 600.0, 6.42848e-40, 800.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpbh_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpbh_ps(create_random__m256(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtpbh_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_min_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtpbh_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, -3.4028235e38, 2.75506e-40, -3.4028235e38, 4.59177e-40, -3.4028235e38, 6.42848e-40, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpbh_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpbh_ps(create_random__m256(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_max_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtpbh_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, 3.4028235e38, 2.75506e-40, 3.4028235e38, 4.59177e-40, 3.4028235e38, 6.42848e-40, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpbh_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpbh_ps(create_random__m256(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_zero_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtpbh_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpbh_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpbh_ps(create_random__m256(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_allones_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtpbh_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, f32::NAN, 2.75506e-40, f32::NAN, 4.59177e-40, f32::NAN, 6.42848e-40, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpbh_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpbh_ps(create_random__m256(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_mixed_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtpbh_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, -f32::INFINITY, 2.75506e-40, 5.877472e-39, 4.59177e-40, -f32::INFINITY, 6.42848e-40, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpbh_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpbh_ps(create_random__m256(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtpbh_ps_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_cvtpbh_ps(create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtpbh_ps(create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtpbh_ps(create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtpbh_ps() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtpbh_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtpbh_ps_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtpbh_ps(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cvtpbh_ps(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtpbh_ps(create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtpbh_ps() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtpbh_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpbh_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_float_array_equality(&result, &[4.59177e-40, 2.0, 6.42848e-40, 4.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpbh_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpbh_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtpbh_ps() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtpbh_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_normal2_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpbh_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, -1.0, 2.75506e-40, -3.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpbh_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpbh_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtpbh_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_normal3_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpbh_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, 200.0, 2.75506e-40, 400.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpbh_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpbh_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtpbh_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_min_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpbh_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, -3.4028235e38, 2.75506e-40, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_cvtpbh_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpbh_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_max_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpbh_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, 3.4028235e38, 2.75506e-40, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_cvtpbh_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpbh_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_zero_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpbh_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_mask_cvtpbh_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpbh_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_allones_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpbh_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, f32::NAN, 2.75506e-40, f32::NAN]).map_err(|e| format!("{e} | call: _mm_mask_cvtpbh_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpbh_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_mixed_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpbh_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, -f32::INFINITY, 2.75506e-40, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_mask_cvtpbh_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpbh_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtpbh_ps_impl() -> Result<(), String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_cvtpbh_ps(create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_cvtpbh_ps(create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtpbh_ps(create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtpbh_ps() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtpbh_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtneps_pbh_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_cvtneps_pbh(create__m128_from([1.0, 2.0, 3.0, 4.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtneps_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtneps_pbh() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtneps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtneps_pbh_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_cvtneps_pbh(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtneps_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtneps_pbh_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtneps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtneps_pbh_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_cvtneps_pbh(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtneps_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtneps_pbh_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtneps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_cvtneps_pbh(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtneps_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtneps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_cvtneps_pbh(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtneps_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtneps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_cvtneps_pbh(create__m128_from([0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtneps_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtneps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_cvtneps_pbh(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtneps_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtneps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_cvtneps_pbh(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtneps_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_cvtneps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([9.0, 10.0, 11.0, 12.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtneps_pbh() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtneps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtneps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtneps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtneps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtneps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtneps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(());
        }
    unsafe {
        let _result = _mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_mixed_impl() }
}
