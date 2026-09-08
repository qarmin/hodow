#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_expand_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_expand_ps(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 2.0, 0.0, 3.0, 0.0, 4.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_expand_ps(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_expand_ps(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_expand_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_expand_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_expand_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_expand_ps(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_float_array_equality(&result, &[0.0, 0.0, -1.0, 0.0, 2.0, 0.0, -3.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_expand_ps(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_expand_ps(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_expand_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_expand_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_expand_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_expand_ps(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32])));
        check_float_array_equality(&result, &[100.0, 0.0, 200.0, 0.0, 300.0, 0.0, 400.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_expand_ps(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_expand_ps(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_expand_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_expand_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_expand_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_expand_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_expand_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_expand_ps(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_expand_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_expand_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_expand_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_expand_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_expand_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_expand_ps(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_expand_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_expand_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_expand_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_expand_ps(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_expand_ps(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_expand_ps(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_expand_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_expand_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_expand_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_expand_ps(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_expand_ps(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_expand_ps(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_expand_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_expand_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_expand_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_expand_ps(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -0.0, 0.0, 5.877472e-39, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_expand_ps(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_expand_ps(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_expand_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_expand_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_expand_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 6.0, 4.0]).map_err(|e| format!("{e} | call: _mm_mask_expand_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_ps(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_expand_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[10.0, -1.0, 9.0, -3.0]).map_err(|e| format!("{e} | call: _mm_mask_expand_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_ps(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_expand_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[110.0, 200.0, 210.0, 400.0]).map_err(|e| format!("{e} | call: _mm_mask_expand_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_ps(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_expand_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_expand_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_ps(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_expand_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_expand_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_ps(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_expand_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_mask_expand_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_ps(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_expand_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_mask_expand_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_ps(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_expand_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -f32::INFINITY, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_mask_expand_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_ps(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_ps_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_expand_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_expand_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_ps(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_ps_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_ps_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_ps_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_expand_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_expand_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_ps(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_ps_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_ps_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_expand_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_expand_ps(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 2.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_expand_ps(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_expand_ps(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_expand_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_expand_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_expand_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_expand_ps(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_float_array_equality(&result, &[0.0, 0.0, -1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_expand_ps(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_expand_ps(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_expand_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_expand_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_expand_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_expand_ps(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_float_array_equality(&result, &[100.0, 0.0, 200.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_expand_ps(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_expand_ps(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_expand_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_expand_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_expand_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_expand_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, 0.0, -3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_expand_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_expand_ps(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_expand_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_expand_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_expand_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_expand_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 0.0, 3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_expand_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_expand_ps(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_expand_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_expand_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_expand_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_expand_ps(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_expand_ps(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_expand_ps(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_expand_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_expand_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_expand_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_expand_ps(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_expand_ps(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_expand_ps(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_expand_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_expand_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_expand_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_expand_ps(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, -f32::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_expand_ps(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_expand_ps(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_expand_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_expand_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_expand_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_expand_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[9.0, 2.0, 10.0, 4.0, 11.0, 6.0, 12.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_expand_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_expand_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_expand_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_expand_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_expand_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_expand_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64])));
        check_float_array_equality(&result, &[10.0, -1.0, 9.0, -3.0, 12.0, -5.0, 7.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_expand_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_expand_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_expand_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_expand_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_expand_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_expand_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64])));
        check_float_array_equality(&result, &[110.0, 200.0, 210.0, 400.0, 310.0, 600.0, 410.0, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_expand_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_expand_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_expand_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_expand_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_expand_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_expand_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_expand_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_expand_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_expand_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_expand_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_expand_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_expand_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_expand_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_expand_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_expand_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_expand_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_expand_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_expand_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_mask_expand_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_expand_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_expand_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_expand_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_expand_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_expand_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_expand_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_expand_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_expand_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_expand_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_expand_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_expand_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -f64::INFINITY, 1.1125369292536007e-308, -0.0, -f64::INFINITY, 1.1125369292536007e-308, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm512_mask_expand_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_expand_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_expand_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_expand_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_expand_pd_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_expand_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_expand_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_expand_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_expand_pd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_expand_pd_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_expand_pd_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_expand_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_expand_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_expand_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_expand_pd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_expand_pd_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_expand_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_expand_pd(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 2.0, 0.0, 3.0, 0.0, 4.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_expand_pd(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_expand_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_expand_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_expand_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_expand_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_expand_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0, -1.0, 0.0, 2.0, 0.0, -3.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_expand_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_expand_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_expand_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_expand_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_expand_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_expand_pd(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64])));
        check_float_array_equality(&result, &[100.0, 0.0, 200.0, 0.0, 300.0, 0.0, 400.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_expand_pd(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_expand_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_expand_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_expand_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_expand_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_expand_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_expand_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_expand_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_expand_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_expand_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_expand_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_expand_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_expand_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_expand_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_expand_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_expand_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_expand_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_expand_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_expand_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_expand_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_expand_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_expand_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_expand_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_expand_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0, f64::NAN, 0.0, f64::NAN, 0.0, f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_expand_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_expand_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_expand_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_expand_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_expand_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_expand_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, -f64::INFINITY, 0.0, -0.0, 0.0, 1.1125369292536007e-308, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_expand_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_expand_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_expand_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_expand_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_expand_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_expand_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 6.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_mask_expand_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_expand_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_expand_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_expand_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_expand_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_expand_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__mmask8_from(0b01010101), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64])));
        check_float_array_equality(&result, &[10.0, -1.0, 9.0, -3.0]).map_err(|e| format!("{e} | call: _mm256_mask_expand_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__mmask8_from(0b01010101), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_expand_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_expand_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_expand_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_expand_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_expand_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__mmask8_from(0b01010101), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64])));
        check_float_array_equality(&result, &[110.0, 200.0, 210.0, 400.0]).map_err(|e| format!("{e} | call: _mm256_mask_expand_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__mmask8_from(0b01010101), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_expand_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_expand_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_expand_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_expand_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_expand_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_expand_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_expand_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_expand_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_expand_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_expand_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_expand_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_expand_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_expand_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_expand_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_expand_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_expand_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_expand_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_mask_expand_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_expand_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_expand_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_expand_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_expand_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_expand_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_mask_expand_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_expand_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_expand_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_expand_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_expand_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_expand_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -f64::INFINITY, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm256_mask_expand_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_expand_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_expand_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_expand_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_expand_pd_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_expand_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_expand_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_expand_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_expand_pd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_expand_pd_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_expand_pd_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_expand_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_expand_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_expand_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_expand_pd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_expand_pd_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_expand_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_expand_pd(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 2.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_expand_pd(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_expand_pd(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_expand_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_expand_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_expand_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_expand_pd(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0, -1.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_expand_pd(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_expand_pd(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_expand_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_expand_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_expand_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_expand_pd(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64])));
        check_float_array_equality(&result, &[100.0, 0.0, 200.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_expand_pd(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_expand_pd(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_expand_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_expand_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_expand_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_expand_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_expand_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_expand_pd(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_expand_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_expand_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_expand_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_expand_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_expand_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_expand_pd(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_expand_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_expand_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_expand_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_expand_pd(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_expand_pd(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_expand_pd(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_expand_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_expand_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_expand_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_expand_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0, f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_expand_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_expand_pd(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_expand_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_expand_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_expand_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_expand_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, -f64::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_expand_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_expand_pd(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_expand_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_expand_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_expand_pd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| format!("{e} | call: _mm_mask_expand_pd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_expand_pd(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[10.0, -1.0]).map_err(|e| format!("{e} | call: _mm_mask_expand_pd(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_expand_pd(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[110.0, 200.0]).map_err(|e| format!("{e} | call: _mm_mask_expand_pd(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_expand_pd(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_expand_pd(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_expand_pd(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_expand_pd(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_expand_pd(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_mask_expand_pd(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_expand_pd(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_mask_expand_pd(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_expand_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_mask_expand_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_pd_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_expand_pd(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_expand_pd(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_pd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_pd_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_expand_pd_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_expand_pd(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_expand_pd(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_expand_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_expand_pd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_expand_pd_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_expand_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_expand_pd(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_expand_pd(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_expand_pd(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_expand_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_expand_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_expand_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_expand_pd(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_expand_pd(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_expand_pd(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_expand_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_expand_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_expand_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_expand_pd(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64])));
        check_float_array_equality(&result, &[100.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_expand_pd(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_expand_pd(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_expand_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_expand_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_expand_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_expand_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_expand_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_expand_pd(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_expand_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_expand_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_expand_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_expand_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_expand_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_expand_pd(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_expand_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_expand_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_expand_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_expand_pd(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_expand_pd(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_expand_pd(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_expand_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_expand_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_expand_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_expand_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_expand_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_expand_pd(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_expand_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_expand_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_expand_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_expand_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_expand_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_expand_pd(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_expand_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_expand_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sll_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_sll_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sll_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_sll_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sll_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_sll_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sll_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_sll_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sll_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_sll_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sll_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_sll_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sll_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_sll_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sll_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_sll_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi32_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sll_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_sll_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi32_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sll_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_sll_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sll_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36])));
        check_array_equality(&result, &[0, 2, 0, 4, 0, 6, 0, 8, 0, 10, 0, 12, 0, 14, 0, 16]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sll_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[0, -1, 0, -3, 0, -5, 0, -7, 0, -1, 0, -3, 0, -5, 0, -7]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i32_array([20, 19, 22, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sll_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m128i_from_i32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[0, 200, 0, 400, 0, 600, 0, 800, 0, 1000, 0, 1200, 0, 1400, 0, 1600]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m128i_from_i32_array([120, 220, 320, 420]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sll_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sll_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sll_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sll_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sll_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 2147483647, 0, -1, 0, 2147483647, 0, -1, 0, 2147483647, 0, -1, 0, 2147483647, 0, -1]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi32_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sll_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi32_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sll_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi32_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi32_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sll_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[0, 2, 0, 4, 0, 6, 0, 8]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sll_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[0, -1, 0, -3, 0, -5, 0, -7]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i32_array([20, 19, 22, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sll_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[0, 200, 0, 400, 0, 600, 0, 800]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i32_array([120, 220, 320, 420]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sll_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sll_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sll_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sll_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sll_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 2147483647, 0, -1, 0, 2147483647, 0, -1]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi32_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sll_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi32_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sll_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi32_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi32_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sll_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0, 2, 0, 4]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sll_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[0, -1, 0, -3]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sll_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[0, 200, 0, 400]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sll_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sll_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sll_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sll_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sll_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 2147483647, 0, -1]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi32_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sll_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi32_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sll_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi32_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi32_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_srl_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_srl_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_srl_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_srl_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_srl_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_srl_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_srl_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_srl_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_srl_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_srl_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_srl_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_srl_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_srl_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_srl_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_srl_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_srl_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi32_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_srl_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_srl_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi32_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_srl_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_srl_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_srl_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36])));
        check_array_equality(&result, &[0, 2, 0, 4, 0, 6, 0, 8, 0, 10, 0, 12, 0, 14, 0, 16]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_srl_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[0, -1, 0, -3, 0, -5, 0, -7, 0, -1, 0, -3, 0, -5, 0, -7]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i32_array([20, 19, 22, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_srl_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m128i_from_i32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[0, 200, 0, 400, 0, 600, 0, 800, 0, 1000, 0, 1200, 0, 1400, 0, 1600]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m128i_from_i32_array([120, 220, 320, 420]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_srl_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_srl_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_srl_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_srl_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_srl_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 2147483647, 0, -1, 0, 2147483647, 0, -1, 0, 2147483647, 0, -1, 0, 2147483647, 0, -1]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi32_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_srl_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi32_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_srl_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi32_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi32_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_srl_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[0, 2, 0, 4, 0, 6, 0, 8]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_srl_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[0, -1, 0, -3, 0, -5, 0, -7]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i32_array([20, 19, 22, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_srl_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[0, 200, 0, 400, 0, 600, 0, 800]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i32_array([120, 220, 320, 420]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_srl_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_srl_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_srl_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_srl_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_srl_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 2147483647, 0, -1, 0, 2147483647, 0, -1]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi32_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_srl_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi32_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_srl_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi32_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi32_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_srl_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0, 2, 0, 4]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_srl_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[0, -1, 0, -3]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_srl_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[0, 200, 0, 400]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_srl_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_srl_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_srl_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_srl_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_srl_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 2147483647, 0, -1]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi32_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_srl_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi32_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_srl_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi32_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi32_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sll_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_sll_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sll_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0, -1024, 2048, -3072, 4096, -5120, 6144, -7168]).map_err(|e| format!("{e} | call: _mm512_sll_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i64_array([10, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sll_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_sll_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i64_array([110, 210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sll_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_sll_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sll_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_sll_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sll_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_sll_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sll_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_sll_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sll_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_sll_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi64_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sll_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_sll_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sll_epi64_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sll_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_sll_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sll_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sll_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sll_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sll_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36])));
        check_array_equality(&result, &[0, 17179869187, 0, 34359738375, 0, 51539607563, 0, 68719476751]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sll_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i64_array([20, 19])));
        check_array_equality(&result, &[10485760, -1, 12582912, -3, 14680064, -5, 16777216, -7]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i64_array([20, 19]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sll_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i64_array([120, 220])));
        check_array_equality(&result, &[0, 200, 0, 400, 0, 600, 0, 800]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i64_array([120, 220]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sll_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sll_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sll_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sll_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sll_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, -1, 0, 9223372036854775807, 0, -1]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi64_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sll_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sll_epi64_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sll_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm512_mask_sll_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sll_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sll_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sll_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0, 0, 2048, 0, 4096, 0, 6144, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i64_array([10, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i64_array([110, 210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi64_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sll_epi64_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sll_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sll_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sll_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sll_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[0, 17179869187, 0, 34359738375]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi64_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sll_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256i_from([10, 9, 12, 7]), create__m128i_from_i64_array([20, 19])));
        check_array_equality(&result, &[10485760, -1, 12582912, -3]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256i_from([10, 9, 12, 7]), create__m128i_from_i64_array([20, 19]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi64_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sll_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256i_from([110, 210, 310, 410]), create__m128i_from_i64_array([120, 220])));
        check_array_equality(&result, &[0, 200, 0, 400]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256i_from([110, 210, 310, 410]), create__m128i_from_i64_array([120, 220]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi64_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sll_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, -9223372036854775808, 0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi64_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sll_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi64_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sll_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi64_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sll_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi64_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sll_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, -1]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi64_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sll_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -9223372036854775808, 0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sll_epi64_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sll_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm256_mask_sll_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sll_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sll_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sll_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi64_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, -1, 2, -3]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0, 0, 2048, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, -1, 2, -3]), create__m128i_from_i64_array([10, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi64_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from([100, 200, 300, 400]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from([100, 200, 300, 400]), create__m128i_from_i64_array([110, 210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi64_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi64_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi64_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi64_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi64_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi64_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sll_epi64_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sll_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sll_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sll_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_sll_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0, 17179869187]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi64_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_sll_epi64(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9]), create__m128i_from_i64_array([20, 19])));
        check_array_equality(&result, &[10485760, -1]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi64(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9]), create__m128i_from_i64_array([20, 19]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi64_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_sll_epi64(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210]), create__m128i_from_i64_array([120, 220])));
        check_array_equality(&result, &[0, 200]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi64(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210]), create__m128i_from_i64_array([120, 220]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi64_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_sll_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi64_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_sll_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi64_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_sll_epi64(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi64(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi64_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_sll_epi64(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0, -1]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi64(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi64_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_sll_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi64_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_sll_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sll_epi64_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_sll_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm_mask_sll_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sll_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sll_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sll_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi64_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1]), create__m128i_from_i64_array([10, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi64_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200]), create__m128i_from_i64_array([110, 210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi64_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi64_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi64_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi64_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi64_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi64_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sll_epi64_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_sll_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sll_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sll_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sll_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_srl_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_srl_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_srl_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0, 18014398509481983, 0, 18014398509481983, 0, 18014398509481983, 0, 18014398509481983]).map_err(|e| format!("{e} | call: _mm512_srl_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i64_array([10, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_srl_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_srl_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i64_array([110, 210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_srl_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_srl_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_srl_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_srl_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_srl_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_srl_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_srl_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_srl_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_srl_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_srl_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi64_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_srl_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_srl_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_srl_epi64_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_srl_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_srl_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srl_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_srl_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_srl_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_srl_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36])));
        check_array_equality(&result, &[0, 17179869187, 0, 34359738375, 0, 51539607563, 0, 68719476751]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_srl_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i64_array([20, 19])));
        check_array_equality(&result, &[0, -1, 0, -3, 0, -5, 0, -7]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i64_array([20, 19]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_srl_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i64_array([120, 220])));
        check_array_equality(&result, &[0, 200, 0, 400, 0, 600, 0, 800]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i64_array([120, 220]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_srl_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_srl_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_srl_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_srl_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_srl_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, -1, 0, 9223372036854775807, 0, -1]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi64_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_srl_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_srl_epi64_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_srl_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm512_mask_srl_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srl_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_srl_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_srl_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i64_array([10, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i64_array([110, 210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi64_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_srl_epi64_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srl_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_srl_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_srl_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_srl_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[0, 17179869187, 0, 34359738375]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi64_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_srl_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256i_from([10, 9, 12, 7]), create__m128i_from_i64_array([20, 19])));
        check_array_equality(&result, &[0, -1, 0, -3]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256i_from([10, 9, 12, 7]), create__m128i_from_i64_array([20, 19]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi64_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_srl_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256i_from([110, 210, 310, 410]), create__m128i_from_i64_array([120, 220])));
        check_array_equality(&result, &[0, 200, 0, 400]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256i_from([110, 210, 310, 410]), create__m128i_from_i64_array([120, 220]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi64_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_srl_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, -9223372036854775808, 0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi64_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_srl_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi64_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_srl_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi64_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_srl_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi64_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_srl_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, -1]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi64_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_srl_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -9223372036854775808, 0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_srl_epi64_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_srl_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm256_mask_srl_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srl_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_srl_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_srl_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi64_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, -1, 2, -3]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, -1, 2, -3]), create__m128i_from_i64_array([10, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi64_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from([100, 200, 300, 400]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from([100, 200, 300, 400]), create__m128i_from_i64_array([110, 210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi64_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi64_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi64_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi64_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi64_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi64_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_srl_epi64_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srl_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_srl_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_srl_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_srl_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0, 17179869187]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi64_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_srl_epi64(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9]), create__m128i_from_i64_array([20, 19])));
        check_array_equality(&result, &[0, -1]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi64(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9]), create__m128i_from_i64_array([20, 19]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi64_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_srl_epi64(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210]), create__m128i_from_i64_array([120, 220])));
        check_array_equality(&result, &[0, 200]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi64(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210]), create__m128i_from_i64_array([120, 220]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi64_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_srl_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi64_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_srl_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi64_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_srl_epi64(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi64(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi64_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_srl_epi64(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0, -1]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi64(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi64_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_srl_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi64_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_srl_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_srl_epi64_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_srl_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm_mask_srl_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srl_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_srl_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_srl_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi64_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1]), create__m128i_from_i64_array([10, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi64_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200]), create__m128i_from_i64_array([110, 210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi64_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi64_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi64_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi64_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi64_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi64_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_srl_epi64_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_srl_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srl_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_srl_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_srl_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sra_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_sra_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sra_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm512_sra_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sra_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_sra_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sra_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_sra_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sra_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_sra_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sra_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_sra_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sra_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_sra_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sra_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0, -1]).map_err(|e| format!("{e} | call: _mm512_sra_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi32_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sra_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_sra_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi32_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_sra_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_sra_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi32(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sra_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36])));
        check_array_equality(&result, &[0, 2, 0, 4, 0, 6, 0, 8, 0, 10, 0, 12, 0, 14, 0, 16]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sra_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[0, -1, 0, -3, 0, -5, 0, -7, 0, -1, 0, -3, 0, -5, 0, -7]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i32_array([20, 19, 22, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sra_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m128i_from_i32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[0, 200, 0, 400, 0, 600, 0, 800, 0, 1000, 0, 1200, 0, 1400, 0, 1600]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m128i_from_i32_array([120, 220, 320, 420]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sra_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, -2147483648, -1, -2147483648, -1, -2147483648, -1, -2147483648, -1, -2147483648, -1, -2147483648, -1, -2147483648, -1, -2147483648]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sra_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sra_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sra_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sra_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 2147483647, 0, -1, -1, 2147483647, 0, -1, -1, 2147483647, 0, -1, -1, 2147483647, 0, -1]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi32_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sra_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi32_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_sra_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[-1, 2147483647, -1, 2147483647, -1, 2147483647, -1, 2147483647, -1, 2147483647, -1, 2147483647, -1, 2147483647, -1, 2147483647]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi32_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi32_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi32(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sra_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[0, 2, 0, 4, 0, 6, 0, 8]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sra_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[0, -1, 0, -3, 0, -5, 0, -7]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i32_array([20, 19, 22, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sra_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[0, 200, 0, 400, 0, 600, 0, 800]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i32_array([120, 220, 320, 420]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sra_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, -2147483648, -1, -2147483648, -1, -2147483648, -1, -2147483648]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sra_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sra_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sra_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sra_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 2147483647, 0, -1, -1, 2147483647, 0, -1]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi32_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sra_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi32_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_sra_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[-1, 2147483647, -1, 2147483647, -1, 2147483647, -1, 2147483647]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, 0, 0, -1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi32_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi32_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi32(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sra_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sra_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0, 2, 0, 4]).map_err(|e| format!("{e} | call: _mm_mask_sra_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sra_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sra_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sra_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sra_epi32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sra_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[0, -1, 0, -3]).map_err(|e| format!("{e} | call: _mm_mask_sra_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sra_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sra_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sra_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sra_epi32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sra_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[0, 200, 0, 400]).map_err(|e| format!("{e} | call: _mm_mask_sra_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sra_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sra_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sra_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sra_epi32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sra_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, -2147483648, -1, -2147483648]).map_err(|e| format!("{e} | call: _mm_mask_sra_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sra_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sra_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sra_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sra_epi32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sra_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm_mask_sra_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sra_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sra_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sra_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sra_epi32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sra_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_mask_sra_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sra_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sra_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sra_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sra_epi32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sra_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm_mask_sra_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sra_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sra_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sra_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sra_epi32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sra_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 2147483647, 0, -1]).map_err(|e| format!("{e} | call: _mm_mask_sra_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sra_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sra_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sra_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sra_epi32_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sra_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm_mask_sra_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sra_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sra_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sra_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_sra_epi32_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sra_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[-1, 2147483647, -1, 2147483647]).map_err(|e| format!("{e} | call: _mm_mask_sra_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sra_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_sra_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_sra_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sra_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sra_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sra_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sra_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sra_epi32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sra_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sra_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sra_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sra_epi32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sra_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sra_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sra_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sra_epi32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sra_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sra_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sra_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sra_epi32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sra_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sra_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sra_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sra_epi32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sra_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sra_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sra_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sra_epi32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sra_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sra_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sra_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sra_epi32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sra_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sra_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sra_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sra_epi32_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sra_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sra_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sra_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_sra_epi32_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_sra_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sra_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_sra_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_sra_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sra_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_sra_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sra_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm512_sra_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i64_array([10, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sra_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_sra_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i64_array([110, 210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sra_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_sra_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sra_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_sra_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sra_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_sra_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sra_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_sra_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sra_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[-1, 0, 0, -1, -1, 0, 0, -1]).map_err(|e| format!("{e} | call: _mm512_sra_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi64_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sra_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_sra_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_sra_epi64_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_sra_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_sra_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sra_epi64(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sra_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_sra_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sra_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36])));
        check_array_equality(&result, &[0, 17179869187, 0, 34359738375, 0, 51539607563, 0, 68719476751]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sra_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i64_array([20, 19])));
        check_array_equality(&result, &[0, -1, 0, -3, 0, -5, 0, -7]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i64_array([20, 19]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sra_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i64_array([120, 220])));
        check_array_equality(&result, &[0, 200, 0, 400, 0, 600, 0, 800]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i64_array([120, 220]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sra_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-1, -9223372036854775808, -1, -9223372036854775808, -1, -9223372036854775808, -1, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sra_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sra_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sra_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sra_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[-1, 9223372036854775807, 0, -1, -1, 9223372036854775807, 0, -1]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi64_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sra_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_sra_epi64_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_sra_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[-1, 9223372036854775807, -1, 9223372036854775807, -1, 9223372036854775807, -1, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm512_mask_sra_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sra_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sra_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_sra_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i64_array([10, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i64_array([110, 210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[-1, 0, 0, 0, -1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi64_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_sra_epi64_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sra_epi64(create_random__mmask8(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sra_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_sra_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_sra_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sra_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_sra_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_sra_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_sra_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_sra_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sra_epi64(create__m256i_from([0, -1, 2, -3]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm256_sra_epi64(create__m256i_from([0, -1, 2, -3]), create__m128i_from_i64_array([10, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_sra_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_sra_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_sra_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sra_epi64(create__m256i_from([100, 200, 300, 400]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_sra_epi64(create__m256i_from([100, 200, 300, 400]), create__m128i_from_i64_array([110, 210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_sra_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_sra_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_sra_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sra_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_sra_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_sra_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_sra_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_sra_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sra_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_sra_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_sra_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_sra_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_sra_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sra_epi64(create__m256i_from([0, 0, 0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_sra_epi64(create__m256i_from([0, 0, 0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_sra_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_sra_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_sra_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sra_epi64(create__m256i_from([-1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_sra_epi64(create__m256i_from([-1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_sra_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_sra_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_sra_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sra_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[-1, 0, 0, -1]).map_err(|e| format!("{e} | call: _mm256_sra_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_sra_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_sra_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_sra_epi64_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sra_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_sra_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_sra_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_sra_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_sra_epi64_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sra_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_sra_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_sra_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_sra_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sra_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[0, 17179869187, 0, 34359738375]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sra_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256i_from([10, 9, 12, 7]), create__m128i_from_i64_array([20, 19])));
        check_array_equality(&result, &[0, -1, 0, -3]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256i_from([10, 9, 12, 7]), create__m128i_from_i64_array([20, 19]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sra_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256i_from([110, 210, 310, 410]), create__m128i_from_i64_array([120, 220])));
        check_array_equality(&result, &[0, 200, 0, 400]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256i_from([110, 210, 310, 410]), create__m128i_from_i64_array([120, 220]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sra_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-1, -9223372036854775808, -1, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sra_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sra_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sra_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sra_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[-1, 9223372036854775807, 0, -1]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi64_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sra_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -9223372036854775808, 0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_sra_epi64_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_sra_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[-1, 9223372036854775807, -1, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm256_mask_sra_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_sra_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_sra_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_sra_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, -1, 2, -3]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, -1, 2, -3]), create__m128i_from_i64_array([10, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from([100, 200, 300, 400]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from([100, 200, 300, 400]), create__m128i_from_i64_array([110, 210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[-1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi64_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_sra_epi64_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_sra_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi64(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_sra_epi64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_sra_epi64_asym_max_min_impl() }
}
