#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmple_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_ps_mask(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnle_ps_mask(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_ps_mask(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnle_ps_mask(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_ps_mask(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnle_ps_mask(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnle_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnle_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_ps_mask(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnle_ps_mask(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_ps_mask(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpnle_ps_mask(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_ps_mask(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnle_ps_mask(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnle_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpnle_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_ps_mask(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpeq_ps_mask(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_ps_mask(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpeq_ps_mask(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_ps_mask(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpeq_ps_mask(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpeq_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpeq_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_ps_mask(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpeq_ps_mask(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_ps_mask(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpeq_ps_mask(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_ps_mask(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpeq_ps_mask(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpeq_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpeq_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_ps_mask(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpneq_ps_mask(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_ps_mask(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpneq_ps_mask(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_ps_mask(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpneq_ps_mask(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpneq_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpneq_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_ps_mask(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpneq_ps_mask(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_ps_mask(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpneq_ps_mask(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_ps_mask(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpneq_ps_mask(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpneq_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpneq_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_ps_mask::<0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_ps_mask::<0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_ps_mask::<0>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_ps_mask::<0>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_ps_mask::<0>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_ps_mask::<0>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_ps_mask::<0>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_ps_mask::<0>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_ps_mask::<0>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_ps_mask::<0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmp_ps_mask::<0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_ps_mask::<0>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_ps_mask::<0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmp_ps_mask::<0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_ps_mask::<0>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_ps_mask::<0>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmp_ps_mask::<0>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_ps_mask::<0>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_ps_mask::<0>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_ps_mask::<0>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_ps_mask::<0>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_ps_mask::<0>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmp_ps_mask::<0>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_ps_mask::<0>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_ps_mask::<0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_ps_mask::<0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_ps_mask::<0>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_ps_mask::<0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_ps_mask::<0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_ps_mask::<0>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_ps_mask_imm_0_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_ps_mask::<0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_ps_mask::<0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_ps_mask::<0>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_ps_mask_imm_0() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_ps_mask_imm_0_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_ps_mask_imm_1_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_ps_mask::<1>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmp_ps_mask::<1>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_ps_mask::<1>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_ps_mask_imm_1() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_ps_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_ps_mask::<0>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_ps_mask::<0>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_ps_mask::<0>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_ps_mask::<0>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_ps_mask::<0>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_ps_mask::<0>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_ps_mask::<0>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_ps_mask::<0>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_ps_mask::<0>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_ps_mask::<0>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_ps_mask_imm_0_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_ps_mask::<0>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_ps_mask_imm_0() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_ps_mask_imm_0_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_ps_mask_imm_1_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_ps_mask::<1>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmp_ps_mask::<1>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_ps_mask::<1>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_ps_mask_imm_1() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_ps_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_ps_mask::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_cmp_ps_mask::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps_mask::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_ps_mask::<0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_cmp_ps_mask::<0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps_mask::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_ps_mask::<0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_cmp_ps_mask::<0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps_mask::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_ps_mask::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm256_cmp_ps_mask::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps_mask::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_ps_mask::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm256_cmp_ps_mask::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps_mask::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_ps_mask::<0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm256_cmp_ps_mask::<0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps_mask::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_ps_mask::<0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_cmp_ps_mask::<0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps_mask::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_ps_mask::<0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm256_cmp_ps_mask::<0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps_mask::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_ps_mask::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_cmp_ps_mask::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps_mask::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_ps_mask::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_cmp_ps_mask::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps_mask::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_ps_mask_imm_0_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_ps_mask::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_cmp_ps_mask::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps_mask::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_ps_mask_imm_0() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_ps_mask_imm_0_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_ps_mask_imm_1_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_ps_mask::<1>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm256_cmp_ps_mask::<1>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps_mask::<1>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_ps_mask_imm_1() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_ps_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_ps_mask_imm_0_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_ps_mask_imm_0() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_ps_mask_imm_0_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_ps_mask_imm_1_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_ps_mask::<1>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm256_mask_cmp_ps_mask::<1>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_ps_mask::<1>(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_ps_mask_imm_1() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_ps_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ps_mask::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_ps_mask::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ps_mask::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_ps_mask::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ps_mask::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_ps_mask::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ps_mask::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 15).map_err(|e| format!("{e} | call: _mm_cmp_ps_mask::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ps_mask::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 15).map_err(|e| format!("{e} | call: _mm_cmp_ps_mask::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ps_mask::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 15).map_err(|e| format!("{e} | call: _mm_cmp_ps_mask::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ps_mask::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_ps_mask::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ps_mask::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 15).map_err(|e| format!("{e} | call: _mm_cmp_ps_mask::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ps_mask::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_ps_mask::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ps_mask::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_ps_mask::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ps_mask_imm_0_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ps_mask::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_ps_mask::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ps_mask_imm_0() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ps_mask_imm_0_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ps_mask_imm_1_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ps_mask::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 15).map_err(|e| format!("{e} | call: _mm_cmp_ps_mask::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps_mask::<1>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ps_mask_imm_1() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ps_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 5).map_err(|e| format!("{e} | call: _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 5).map_err(|e| format!("{e} | call: _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 5).map_err(|e| format!("{e} | call: _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 5).map_err(|e| format!("{e} | call: _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ps_mask_imm_0_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ps_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ps_mask_imm_0() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ps_mask_imm_0_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ps_mask_imm_1_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ps_mask::<1>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 5).map_err(|e| format!("{e} | call: _mm_mask_cmp_ps_mask::<1>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ps_mask::<1>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ps_mask_imm_1() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ps_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_ps_mask::<0, 8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_ps_mask::<0, 8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_ps_mask::<0, 8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_ps_mask::<0, 8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_ps_mask::<0, 8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_ps_mask::<0, 8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_ps_mask::<0, 8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_ps_mask::<0, 8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_ps_mask::<0, 8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_round_ps_mask::<0, 8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_ps_mask::<0, 8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_ps_mask::<0, 8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_ps_mask::<0, 8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_ps_mask::<0, 8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_ps_mask::<0, 8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_ps_mask::<0, 8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_ps_mask::<0, 8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_ps_mask::<0, 8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_ps_mask::<0, 8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_ps_mask::<0, 8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_ps_mask::<0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_ps_mask::<0, 8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_ps_mask(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpord_ps_mask(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_ps_mask(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpord_ps_mask(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_ps_mask(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpord_ps_mask(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpord_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpord_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_ps_mask(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpord_ps_mask(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_ps_mask(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpord_ps_mask(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_ps_mask(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpord_ps_mask(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpord_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpord_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_ps_mask(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpunord_ps_mask(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_ps_mask(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpunord_ps_mask(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_ps_mask(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpunord_ps_mask(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpunord_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpunord_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_ps_mask(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpunord_ps_mask(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_ps_mask(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm512_cmpunord_ps_mask(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_ps_mask(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpunord_ps_mask(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpunord_ps_mask(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpunord_ps_mask(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_ps_mask(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_ps_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_ps_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_ps_mask(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_ps_mask(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_ps_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_ps_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmplt_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmplt_pd_mask(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmplt_pd_mask(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmplt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmplt_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmplt_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmplt_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmplt_pd_mask(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmplt_pd_mask(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmplt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmplt_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmplt_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmplt_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmplt_pd_mask(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmplt_pd_mask(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmplt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmplt_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmplt_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmplt_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmplt_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmplt_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmplt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmplt_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmplt_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmplt_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmplt_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmplt_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmplt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmplt_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmplt_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmplt_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmplt_pd_mask(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmplt_pd_mask(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmplt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmplt_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmplt_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmplt_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmplt_pd_mask(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmplt_pd_mask(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmplt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmplt_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmplt_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmplt_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmplt_pd_mask(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmplt_pd_mask(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmplt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmplt_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmplt_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmplt_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmplt_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmplt_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmplt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmplt_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmplt_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmplt_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmplt_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmplt_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmplt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmplt_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmplt_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmplt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmplt_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmplt_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmplt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmplt_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmplt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmplt_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmplt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmplt_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmplt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmplt_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmplt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmplt_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmplt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmplt_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmplt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmplt_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmplt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmplt_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmplt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmplt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmplt_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmplt_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnlt_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnlt_pd_mask(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnlt_pd_mask(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnlt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnlt_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnlt_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnlt_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnlt_pd_mask(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnlt_pd_mask(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnlt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnlt_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnlt_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnlt_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnlt_pd_mask(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnlt_pd_mask(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnlt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnlt_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnlt_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnlt_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnlt_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpnlt_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnlt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnlt_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnlt_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnlt_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnlt_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpnlt_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnlt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnlt_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnlt_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnlt_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnlt_pd_mask(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpnlt_pd_mask(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnlt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnlt_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnlt_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnlt_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnlt_pd_mask(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpnlt_pd_mask(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnlt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnlt_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnlt_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnlt_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnlt_pd_mask(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpnlt_pd_mask(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnlt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnlt_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnlt_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnlt_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnlt_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnlt_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnlt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnlt_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnlt_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnlt_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnlt_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpnlt_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnlt_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnlt_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnlt_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnlt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnlt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnlt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnlt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnlt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnlt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnlt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnlt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnlt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpnlt_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnlt_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnlt_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmple_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmple_pd_mask(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmple_pd_mask(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmple_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmple_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmple_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmple_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmple_pd_mask(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmple_pd_mask(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmple_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmple_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmple_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmple_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmple_pd_mask(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmple_pd_mask(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmple_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmple_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmple_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmple_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmple_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmple_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmple_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmple_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmple_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmple_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmple_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmple_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmple_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmple_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmple_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmple_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmple_pd_mask(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmple_pd_mask(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmple_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmple_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmple_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmple_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmple_pd_mask(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmple_pd_mask(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmple_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmple_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmple_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmple_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmple_pd_mask(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmple_pd_mask(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmple_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmple_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmple_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmple_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmple_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmple_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmple_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmple_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmple_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmple_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmple_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmple_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmple_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmple_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmple_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmple_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmple_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmple_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmple_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmple_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_pd_mask(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnle_pd_mask(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_pd_mask(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnle_pd_mask(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_pd_mask(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnle_pd_mask(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnle_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnle_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_pd_mask(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnle_pd_mask(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_pd_mask(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpnle_pd_mask(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_pd_mask(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnle_pd_mask(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpnle_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpnle_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpnle_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpnle_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpnle_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpnle_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpnle_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpnle_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpnle_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpnle_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpnle_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_pd_mask(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpeq_pd_mask(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_pd_mask(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpeq_pd_mask(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_pd_mask(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpeq_pd_mask(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpeq_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpeq_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_pd_mask(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpeq_pd_mask(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_pd_mask(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpeq_pd_mask(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_pd_mask(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpeq_pd_mask(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpeq_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpeq_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpeq_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpeq_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpeq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpeq_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpeq_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpeq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpeq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpeq_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpeq_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_pd_mask(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpneq_pd_mask(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_pd_mask(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpneq_pd_mask(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_pd_mask(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpneq_pd_mask(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpneq_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpneq_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_pd_mask(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpneq_pd_mask(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_pd_mask(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpneq_pd_mask(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_pd_mask(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpneq_pd_mask(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpneq_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpneq_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpneq_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpneq_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpneq_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpneq_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpneq_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpneq_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpneq_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpneq_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpneq_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_pd_mask::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_pd_mask::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_pd_mask::<0>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_pd_mask::<0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_pd_mask::<0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_pd_mask::<0>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_pd_mask::<0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_pd_mask::<0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_pd_mask::<0>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_pd_mask::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmp_pd_mask::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_pd_mask::<0>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_pd_mask::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmp_pd_mask::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_pd_mask::<0>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_pd_mask::<0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmp_pd_mask::<0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_pd_mask::<0>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_pd_mask::<0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_pd_mask::<0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_pd_mask::<0>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_pd_mask::<0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmp_pd_mask::<0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_pd_mask::<0>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_pd_mask::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_pd_mask::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_pd_mask::<0>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_pd_mask::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_pd_mask::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_pd_mask::<0>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_pd_mask_imm_0_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_pd_mask::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_pd_mask::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_pd_mask::<0>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_pd_mask_imm_0() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_pd_mask_imm_0_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_pd_mask_imm_1_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_pd_mask::<1>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmp_pd_mask::<1>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_pd_mask::<1>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_pd_mask_imm_1() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_pd_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_pd_mask_imm_0_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_pd_mask_imm_0() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_pd_mask_imm_0_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_pd_mask_imm_1_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_pd_mask::<1>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmp_pd_mask::<1>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_pd_mask::<1>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_pd_mask_imm_1() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_pd_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_pd_mask::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_cmp_pd_mask::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd_mask::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_pd_mask::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_cmp_pd_mask::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd_mask::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_pd_mask::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_cmp_pd_mask::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd_mask::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_pd_mask::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 15).map_err(|e| format!("{e} | call: _mm256_cmp_pd_mask::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd_mask::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_pd_mask::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 15).map_err(|e| format!("{e} | call: _mm256_cmp_pd_mask::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd_mask::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_pd_mask::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 15).map_err(|e| format!("{e} | call: _mm256_cmp_pd_mask::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd_mask::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_pd_mask::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_cmp_pd_mask::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd_mask::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_pd_mask::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 15).map_err(|e| format!("{e} | call: _mm256_cmp_pd_mask::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd_mask::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_pd_mask::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_cmp_pd_mask::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd_mask::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_pd_mask::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_cmp_pd_mask::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd_mask::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_pd_mask_imm_0_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_pd_mask::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_cmp_pd_mask::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd_mask::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_pd_mask_imm_0() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_pd_mask_imm_0_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cmp_pd_mask_imm_1_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_cmp_pd_mask::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 15).map_err(|e| format!("{e} | call: _mm256_cmp_pd_mask::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd_mask::<1>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cmp_pd_mask_imm_1() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cmp_pd_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 5).map_err(|e| format!("{e} | call: _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 5).map_err(|e| format!("{e} | call: _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 5).map_err(|e| format!("{e} | call: _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 5).map_err(|e| format!("{e} | call: _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_pd_mask_imm_0_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_pd_mask_imm_0() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_pd_mask_imm_0_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cmp_pd_mask_imm_1_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_cmp_pd_mask::<1>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 5).map_err(|e| format!("{e} | call: _mm256_mask_cmp_pd_mask::<1>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cmp_pd_mask::<1>(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cmp_pd_mask_imm_1() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cmp_pd_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_pd_mask::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_pd_mask::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_pd_mask::<0>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_pd_mask::<0>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_pd_mask::<0>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_pd_mask::<0>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_pd_mask::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: _mm_cmp_pd_mask::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_pd_mask::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: _mm_cmp_pd_mask::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_pd_mask::<0>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: _mm_cmp_pd_mask::<0>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_pd_mask::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_pd_mask::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_pd_mask::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: _mm_cmp_pd_mask::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_pd_mask::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_pd_mask::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_pd_mask::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_pd_mask::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_pd_mask_imm_0_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_pd_mask::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_pd_mask::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_pd_mask_imm_0() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_pd_mask_imm_0_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_pd_mask_imm_1_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_pd_mask::<1>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: _mm_cmp_pd_mask::<1>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd_mask::<1>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_pd_mask_imm_1() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_pd_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_pd_mask_imm_0_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_pd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_pd_mask_imm_0() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_pd_mask_imm_0_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_pd_mask_imm_1_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_pd_mask::<1>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_pd_mask::<1>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_pd_mask::<1>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_pd_mask_imm_1() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_pd_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_pd_mask::<0, 8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_pd_mask::<0, 8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_pd_mask::<0, 8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_pd_mask::<0, 8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_pd_mask::<0, 8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_pd_mask::<0, 8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_pd_mask::<0, 8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_pd_mask::<0, 8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_pd_mask::<0, 8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmp_round_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmp_round_pd_mask::<0, 8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmp_round_pd_mask::<0, 8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmp_round_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmp_round_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_pd_mask::<0, 8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_pd_mask::<0, 8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_pd_mask::<0, 8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_pd_mask::<0, 8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_pd_mask::<0, 8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_pd_mask::<0, 8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_pd_mask::<0, 8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_pd_mask::<0, 8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_pd_mask::<0, 8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmp_round_pd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmp_round_pd_mask::<0, 8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmp_round_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmp_round_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_pd_mask(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpord_pd_mask(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_pd_mask(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpord_pd_mask(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_pd_mask(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpord_pd_mask(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpord_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpord_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_pd_mask(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpord_pd_mask(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_pd_mask(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpord_pd_mask(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_pd_mask(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpord_pd_mask(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpord_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpord_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpord_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpord_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpord_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpord_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpord_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpord_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_pd_mask(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpunord_pd_mask(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_pd_mask(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpunord_pd_mask(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_pd_mask(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpunord_pd_mask(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpunord_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpunord_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_pd_mask(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpunord_pd_mask(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_pd_mask(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 255).map_err(|e| format!("{e} | call: _mm512_cmpunord_pd_mask(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_pd_mask(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpunord_pd_mask(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpunord_pd_mask(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cmpunord_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_cmpunord_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_cmpunord_pd_mask(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cmpunord_pd_mask(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cmpunord_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cmpunord_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_pd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 85).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_pd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_cmpunord_pd_mask(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cmpunord_pd_mask(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cmpunord_pd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cmpunord_pd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ss_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ss_mask::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_ss_mask::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ss_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ss_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ss_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ss_mask::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_ss_mask::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ss_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ss_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ss_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ss_mask::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_ss_mask::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ss_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ss_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ss_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ss_mask::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmp_ss_mask::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ss_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ss_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ss_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ss_mask::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmp_ss_mask::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ss_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ss_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ss_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ss_mask::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmp_ss_mask::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ss_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ss_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ss_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ss_mask::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_ss_mask::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ss_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ss_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ss_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ss_mask::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmp_ss_mask::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ss_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ss_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ss_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ss_mask::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_ss_mask::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ss_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ss_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ss_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ss_mask::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_ss_mask::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ss_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ss_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ss_mask_imm_0_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ss_mask::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_ss_mask::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss_mask::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ss_mask_imm_0() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ss_mask_imm_0_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_ss_mask_imm_1_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_ss_mask::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmp_ss_mask::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss_mask::<1>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_ss_mask_imm_1() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_ss_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ss_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ss_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ss_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ss_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ss_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ss_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ss_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ss_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ss_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ss_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ss_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ss_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ss_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ss_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ss_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ss_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ss_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ss_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ss_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ss_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ss_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ss_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ss_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ss_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ss_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ss_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ss_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ss_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ss_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ss_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ss_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ss_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ss_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ss_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ss_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ss_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ss_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ss_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ss_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ss_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ss_mask_imm_0_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ss_mask::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ss_mask_imm_0() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ss_mask_imm_0_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_ss_mask_imm_1_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_ss_mask::<1>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_ss_mask::<1>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_ss_mask::<1>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_ss_mask_imm_1() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_ss_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_ss_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_ss_mask::<0, 8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_ss_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_ss_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_ss_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_ss_mask::<0, 8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_ss_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_ss_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_ss_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_ss_mask::<0, 8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_ss_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_ss_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_ss_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_ss_mask::<0, 8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_ss_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_ss_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_ss_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_ss_mask::<0, 8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_ss_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_ss_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_ss_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_ss_mask::<0, 8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_ss_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_ss_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_ss_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_ss_mask::<0, 8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_ss_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_ss_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_ss_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_ss_mask::<0, 8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_ss_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_ss_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_ss_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_ss_mask::<0, 8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_ss_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_ss_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_ss_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_round_ss_mask::<0, 8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_ss_mask::<0, 8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_ss_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_ss_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_ss_mask::<0, 8>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_ss_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_ss_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_ss_mask::<0, 8>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_ss_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_ss_mask::<0, 8>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_ss_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_ss_mask::<0, 8>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_ss_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_ss_mask::<0, 8>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_ss_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_ss_mask::<0, 8>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_ss_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_ss_mask::<0, 8>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_ss_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_ss_mask::<0, 8>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_ss_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_ss_mask::<0, 8>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_ss_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_ss_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_ss_mask::<0, 8>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_ss_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_ss_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_sd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_sd_mask::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_sd_mask::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_sd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_sd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_sd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_sd_mask::<0>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_sd_mask::<0>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_sd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_sd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_sd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_sd_mask::<0>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_sd_mask::<0>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_sd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_sd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_sd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_sd_mask::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmp_sd_mask::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_sd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_sd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_sd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_sd_mask::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmp_sd_mask::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_sd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_sd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_sd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_sd_mask::<0>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmp_sd_mask::<0>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_sd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_sd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_sd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_sd_mask::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_sd_mask::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_sd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_sd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_sd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_sd_mask::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmp_sd_mask::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_sd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_sd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_sd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_sd_mask::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_sd_mask::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_sd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_sd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_sd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_sd_mask::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_sd_mask::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_sd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_sd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_sd_mask_imm_0_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_sd_mask::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_sd_mask::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd_mask::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_sd_mask_imm_0() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_sd_mask_imm_0_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_sd_mask_imm_1_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_sd_mask::<1>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmp_sd_mask::<1>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd_mask::<1>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_sd_mask_imm_1() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_sd_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_sd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_sd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_sd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_sd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_sd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_sd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_sd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_sd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_sd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_sd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_sd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_sd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_sd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_sd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_sd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_sd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_sd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_sd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_sd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_sd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_sd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_sd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_sd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_sd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_sd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_sd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_sd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_sd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_sd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_sd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_sd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_sd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_sd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_sd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_sd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_sd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_sd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_sd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_sd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_sd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_sd_mask_imm_0_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_sd_mask::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_sd_mask_imm_0() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_sd_mask_imm_0_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_sd_mask_imm_1_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_sd_mask::<1>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_sd_mask::<1>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_sd_mask::<1>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_sd_mask_imm_1() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_sd_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_sd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_sd_mask::<0, 8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_sd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_sd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_sd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_sd_mask::<0, 8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_sd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_sd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_sd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_sd_mask::<0, 8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_sd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_sd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_sd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_sd_mask::<0, 8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_sd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_sd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_sd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_sd_mask::<0, 8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_sd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_sd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_sd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_sd_mask::<0, 8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_sd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_sd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_sd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_sd_mask::<0, 8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_sd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_sd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_sd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_sd_mask::<0, 8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_sd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_sd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_sd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_sd_mask::<0, 8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_sd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_sd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cmp_round_sd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cmp_round_sd_mask::<0, 8>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_round_sd_mask::<0, 8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cmp_round_sd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cmp_round_sd_mask_asym_max_min_impl() }
}
