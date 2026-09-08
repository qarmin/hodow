#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_getmant_round_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_getmant_round_ps::<0, 0, 8>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.5, 1.0, 1.25, 1.5, 1.75, 1.0, 1.125, 1.25, 1.375, 1.5, 1.625, 1.75, 1.875, 1.0]).map_err(|e| format!("{e} | call: _mm512_getmant_round_ps::<0, 0, 8>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_round_ps::<0, 0, 8>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_round_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_getmant_round_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_getmant_round_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_getmant_round_ps::<0, 0, 8>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_float_array_equality(&result, &[1.0, -1.0, 1.0, -1.5, 1.0, -1.25, 1.5, -1.75, 1.0, -1.0, 1.0, -1.5, 1.0, -1.25, 1.5, -1.75]).map_err(|e| format!("{e} | call: _mm512_getmant_round_ps::<0, 0, 8>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_round_ps::<0, 0, 8>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_round_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_getmant_round_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_getmant_round_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_getmant_round_ps::<0, 0, 8>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32])));
        check_float_array_equality(&result, &[1.5625, 1.5625, 1.171875, 1.5625, 1.953125, 1.171875, 1.3671875, 1.5625, 1.7578125, 1.953125, 1.0742188, 1.171875, 1.2695313, 1.3671875, 1.4648438, 1.5625]).map_err(|e| format!("{e} | call: _mm512_getmant_round_ps::<0, 0, 8>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_round_ps::<0, 0, 8>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_round_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_getmant_round_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_getmant_round_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999]).map_err(|e| format!("{e} | call: _mm512_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_round_ps::<0, 0, 8>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_round_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_getmant_round_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_getmant_round_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999]).map_err(|e| format!("{e} | call: _mm512_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_round_ps::<0, 0, 8>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_round_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_getmant_round_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_getmant_round_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_getmant_round_ps::<0, 0, 8>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: _mm512_getmant_round_ps::<0, 0, 8>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_round_ps::<0, 0, 8>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_round_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_getmant_round_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_getmant_round_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_round_ps::<0, 0, 8>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_round_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_getmant_round_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_getmant_round_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, -1.0, -1.0, 1.0, 1.0, -1.0, -1.0, 1.0, 1.0, -1.0, -1.0, 1.0, 1.0, -1.0, -1.0, 1.0]).map_err(|e| format!("{e} | call: _mm512_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_round_ps::<0, 0, 8>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_round_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_getmant_round_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_float_array_equality(&result, &[1.0625, 2.0, 1.1875, 4.0, 1.3125, 6.0, 1.4375, 8.0, 1.5625, 10.0, 1.6875, 12.0, 1.8125, 14.0, 1.9375, 16.0]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_ps::<0, 0, 8>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[1.25, -1.0, 1.5, -3.0, 1.75, -5.0, 1.0, -7.0, 1.25, -1.0, 1.5, -3.0, 1.75, -5.0, 1.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_ps::<0, 0, 8>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32])));
        check_float_array_equality(&result, &[1.71875, 200.0, 1.2109375, 400.0, 1.9921875, 600.0, 1.3867188, 800.0, 1.7773438, 1000.0, 1.0839844, 1200.0, 1.2792969, 1400.0, 1.4746094, 1600.0]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_ps::<0, 0, 8>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.9999999, -3.4028235e38, -1.9999999, -3.4028235e38, -1.9999999, -3.4028235e38, -1.9999999, -3.4028235e38, -1.9999999, -3.4028235e38, -1.9999999, -3.4028235e38, -1.9999999, -3.4028235e38, -1.9999999, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_ps::<0, 0, 8>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.9999999, 3.4028235e38, 1.9999999, 3.4028235e38, 1.9999999, 3.4028235e38, 1.9999999, 3.4028235e38, 1.9999999, 3.4028235e38, 1.9999999, 3.4028235e38, 1.9999999, 3.4028235e38, 1.9999999, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_ps::<0, 0, 8>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_ps::<0, 0, 8>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_ps::<0, 0, 8>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, -1.0, 5.877472e-39, 1.0, -f32::INFINITY, -1.0, 5.877472e-39, 1.0, -f32::INFINITY, -1.0, 5.877472e-39, 1.0, -f32::INFINITY, -1.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_ps::<0, 0, 8>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_ps_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.9999999, -3.4028235e38, 1.9999999, -3.4028235e38, 1.9999999, -3.4028235e38, 1.9999999, -3.4028235e38, 1.9999999, -3.4028235e38, 1.9999999, -3.4028235e38, 1.9999999, -3.4028235e38, 1.9999999, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_ps::<0, 0, 8>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_ps_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_ps_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_ps_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.9999999, 3.4028235e38, -1.9999999, 3.4028235e38, -1.9999999, 3.4028235e38, -1.9999999, 3.4028235e38, -1.9999999, 3.4028235e38, -1.9999999, 3.4028235e38, -1.9999999, 3.4028235e38, -1.9999999, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_ps::<0, 0, 8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_ps::<0, 0, 8>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_ps_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_ps_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_getmant_round_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_getmant_round_ps::<0, 0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.5, 0.0, 1.25, 0.0, 1.75, 0.0, 1.125, 0.0, 1.375, 0.0, 1.625, 0.0, 1.875, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_round_ps::<0, 0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_round_ps::<0, 0, 8>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_round_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_getmant_round_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_getmant_round_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_getmant_round_ps::<0, 0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.5, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.5, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_round_ps::<0, 0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_round_ps::<0, 0, 8>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_round_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_getmant_round_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_getmant_round_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_getmant_round_ps::<0, 0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32])));
        check_float_array_equality(&result, &[1.5625, 0.0, 1.171875, 0.0, 1.953125, 0.0, 1.3671875, 0.0, 1.7578125, 0.0, 1.0742188, 0.0, 1.2695313, 0.0, 1.4648438, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_round_ps::<0, 0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_round_ps::<0, 0, 8>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_round_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_getmant_round_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_getmant_round_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_getmant_round_ps::<0, 0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.9999999, 0.0, -1.9999999, 0.0, -1.9999999, 0.0, -1.9999999, 0.0, -1.9999999, 0.0, -1.9999999, 0.0, -1.9999999, 0.0, -1.9999999, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_round_ps::<0, 0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_round_ps::<0, 0, 8>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_round_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_getmant_round_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_getmant_round_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_getmant_round_ps::<0, 0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.9999999, 0.0, 1.9999999, 0.0, 1.9999999, 0.0, 1.9999999, 0.0, 1.9999999, 0.0, 1.9999999, 0.0, 1.9999999, 0.0, 1.9999999, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_round_ps::<0, 0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_round_ps::<0, 0, 8>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_round_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_getmant_round_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_getmant_round_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_getmant_round_ps::<0, 0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_round_ps::<0, 0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_round_ps::<0, 0, 8>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_round_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_getmant_round_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_getmant_round_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_getmant_round_ps::<0, 0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_round_ps::<0, 0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_round_ps::<0, 0, 8>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_round_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_getmant_round_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_getmant_round_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_getmant_round_ps::<0, 0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, 0.0, -1.0, 0.0, 1.0, 0.0, -1.0, 0.0, 1.0, 0.0, -1.0, 0.0, 1.0, 0.0, -1.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_round_ps::<0, 0, 8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_round_ps::<0, 0, 8>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_round_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_getmant_round_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_getmant_round_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_getmant_round_pd::<0, 0, 8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.5, 1.0, 1.25, 1.5, 1.75, 1.0]).map_err(|e| format!("{e} | call: _mm512_getmant_round_pd::<0, 0, 8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_round_pd::<0, 0, 8>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_round_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_getmant_round_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_getmant_round_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_getmant_round_pd::<0, 0, 8>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64])));
        check_float_array_equality(&result, &[1.0, -1.0, 1.0, -1.5, 1.0, -1.25, 1.5, -1.75]).map_err(|e| format!("{e} | call: _mm512_getmant_round_pd::<0, 0, 8>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_round_pd::<0, 0, 8>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_round_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_getmant_round_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_getmant_round_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_getmant_round_pd::<0, 0, 8>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64])));
        check_float_array_equality(&result, &[1.5625, 1.5625, 1.171875, 1.5625, 1.953125, 1.171875, 1.3671875, 1.5625]).map_err(|e| format!("{e} | call: _mm512_getmant_round_pd::<0, 0, 8>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_round_pd::<0, 0, 8>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_round_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_getmant_round_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_getmant_round_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.9999999999999998, -1.9999999999999998, -1.9999999999999998, -1.9999999999999998, -1.9999999999999998, -1.9999999999999998, -1.9999999999999998, -1.9999999999999998]).map_err(|e| format!("{e} | call: _mm512_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_round_pd::<0, 0, 8>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_round_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_getmant_round_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_getmant_round_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.9999999999999998, 1.9999999999999998, 1.9999999999999998, 1.9999999999999998, 1.9999999999999998, 1.9999999999999998, 1.9999999999999998, 1.9999999999999998]).map_err(|e| format!("{e} | call: _mm512_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_round_pd::<0, 0, 8>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_round_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_getmant_round_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_getmant_round_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_getmant_round_pd::<0, 0, 8>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: _mm512_getmant_round_pd::<0, 0, 8>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_round_pd::<0, 0, 8>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_round_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_getmant_round_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_getmant_round_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_round_pd::<0, 0, 8>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_round_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_getmant_round_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_getmant_round_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, -1.0, -1.0, 1.0, 1.0, -1.0, -1.0, 1.0]).map_err(|e| format!("{e} | call: _mm512_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_round_pd::<0, 0, 8>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_round_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_getmant_round_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.125, 2.0, 1.375, 4.0, 1.625, 6.0, 1.875, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_pd::<0, 0, 8>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64])));
        check_float_array_equality(&result, &[1.25, -1.0, 1.5, -3.0, 1.75, -5.0, 1.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_pd::<0, 0, 8>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64])));
        check_float_array_equality(&result, &[1.71875, 200.0, 1.2109375, 400.0, 1.9921875, 600.0, 1.38671875, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_pd::<0, 0, 8>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.9999999999999998, -1.7976931348623157e308, -1.9999999999999998, -1.7976931348623157e308, -1.9999999999999998, -1.7976931348623157e308, -1.9999999999999998, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_pd::<0, 0, 8>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.9999999999999998, 1.7976931348623157e308, 1.9999999999999998, 1.7976931348623157e308, 1.9999999999999998, 1.7976931348623157e308, 1.9999999999999998, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_pd::<0, 0, 8>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_pd::<0, 0, 8>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_pd::<0, 0, 8>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY, -1.0, 1.1125369292536007e-308, 1.0, -f64::INFINITY, -1.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_pd::<0, 0, 8>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_pd_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.9999999999999998, -1.7976931348623157e308, 1.9999999999999998, -1.7976931348623157e308, 1.9999999999999998, -1.7976931348623157e308, 1.9999999999999998, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_pd::<0, 0, 8>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_pd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_pd_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_getmant_round_pd_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.9999999999999998, 1.7976931348623157e308, -1.9999999999999998, 1.7976931348623157e308, -1.9999999999999998, 1.7976931348623157e308, -1.9999999999999998, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_round_pd::<0, 0, 8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_round_pd::<0, 0, 8>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_round_pd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_getmant_round_pd_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_getmant_round_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_getmant_round_pd::<0, 0, 8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.5, 0.0, 1.25, 0.0, 1.75, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_round_pd::<0, 0, 8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_round_pd::<0, 0, 8>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_round_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_getmant_round_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_getmant_round_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_getmant_round_pd::<0, 0, 8>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.5, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_round_pd::<0, 0, 8>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_round_pd::<0, 0, 8>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_round_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_getmant_round_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_getmant_round_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_getmant_round_pd::<0, 0, 8>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64])));
        check_float_array_equality(&result, &[1.5625, 0.0, 1.171875, 0.0, 1.953125, 0.0, 1.3671875, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_round_pd::<0, 0, 8>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_round_pd::<0, 0, 8>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_round_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_getmant_round_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_getmant_round_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_getmant_round_pd::<0, 0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.9999999999999998, 0.0, -1.9999999999999998, 0.0, -1.9999999999999998, 0.0, -1.9999999999999998, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_round_pd::<0, 0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_round_pd::<0, 0, 8>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_round_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_getmant_round_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_getmant_round_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_getmant_round_pd::<0, 0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.9999999999999998, 0.0, 1.9999999999999998, 0.0, 1.9999999999999998, 0.0, 1.9999999999999998, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_round_pd::<0, 0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_round_pd::<0, 0, 8>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_round_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_getmant_round_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_getmant_round_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_getmant_round_pd::<0, 0, 8>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_round_pd::<0, 0, 8>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_round_pd::<0, 0, 8>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_round_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_getmant_round_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_getmant_round_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_getmant_round_pd::<0, 0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0, f64::NAN, 0.0, f64::NAN, 0.0, f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_round_pd::<0, 0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_round_pd::<0, 0, 8>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_round_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_getmant_round_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_getmant_round_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_getmant_round_pd::<0, 0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, 0.0, -1.0, 0.0, 1.0, 0.0, -1.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_round_pd::<0, 0, 8>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_round_pd::<0, 0, 8>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_round_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_getmant_round_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtps_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtps_epi32(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: _mm512_cvtps_epi32(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtps_epi32(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtps_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtps_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtps_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_array_equality(&result, &[17, 2, 19, 4, 21, 6, 23, 8, 25, 10, 27, 12, 29, 14, 31, 16]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtps_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1, -1, 3, -3, 5, -5, 7, -7, 9, -1, 11, -3, 13, -5, 15, -7]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtps_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800, 9, 1000, 11, 1200, 13, 1400, 15, 1600]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtps_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1, -2147483648, 3, -2147483648, 5, -2147483648, 7, -2147483648, 9, -2147483648, 11, -2147483648, 13, -2147483648, 15, -2147483648]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtps_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1, 2147483647, 3, 2147483647, 5, 2147483647, 7, 2147483647, 9, 2147483647, 11, 2147483647, 13, 2147483647, 15, 2147483647]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtps_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0, 9, 0, 11, 0, 13, 0, 15, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtps_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1, -1, 3, -1, 5, -1, 7, -1, 9, -1, 11, -1, 13, -1, 15, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtps_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1, 2147483647, 3, -1, 5, 2147483647, 7, -1, 9, 2147483647, 11, -1, 13, 2147483647, 15, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtps_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtps_epi32(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0, 9, 0, 11, 0, 13, 0, 15, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtps_epi32(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtps_epi32(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtps_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtps_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtps_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtps_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[9, 2, 11, 4, 13, 6, 15, 8]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtps_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtps_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtps_epi32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtps_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -1, 3, -3, 5, -5, 7, -7]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtps_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtps_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtps_epi32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtps_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtps_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtps_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtps_epi32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtps_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -2147483648, 3, -2147483648, 5, -2147483648, 7, -2147483648]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtps_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtps_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtps_epi32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtps_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2147483647, 3, 2147483647, 5, 2147483647, 7, 2147483647]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtps_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtps_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtps_epi32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtps_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtps_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtps_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtps_epi32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtps_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -1, 3, -1, 5, -1, 7, -1]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtps_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtps_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtps_epi32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtps_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2147483647, 3, -1, 5, 2147483647, 7, -1]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtps_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtps_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtps_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvtps_epi32(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtps_epi32(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtps_epi32(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtps_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtps_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtps_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtps_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[5, 2, 7, 4]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtps_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtps_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtps_epi32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtps_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, -1, 3, -3]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtps_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtps_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtps_epi32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtps_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 200, 3, 400]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtps_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtps_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtps_epi32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtps_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, -2147483648, 3, -2147483648]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtps_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtps_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtps_epi32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtps_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2147483647, 3, 2147483647]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtps_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtps_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtps_epi32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtps_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtps_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtps_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtps_epi32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtps_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, -1, 3, -1]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtps_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtps_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtps_epi32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtps_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2147483647, 3, -1]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtps_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtps_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtps_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtps_epi32(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtps_epi32(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtps_epi32(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtps_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtps_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtps_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_cvtps_epu32(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: _mm512_cvtps_epu32(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtps_epu32(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtps_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtps_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mask_cvtps_epu32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_array_equality(&result, &[17, 2, 19, 4, 21, 6, 23, 8, 25, 10, 27, 12, 29, 14, 31, 16]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epu32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epu32(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_epu32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mask_cvtps_epu32(create__m512i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289, 0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967293, 5, 4294967291, 7, 4294967289, 9, 4294967295, 11, 4294967293, 13, 4294967291, 15, 4294967289]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epu32(create__m512i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289, 0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epu32(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_epu32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_epu32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_epu32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mask_cvtps_epu32(create__m512i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800, 9, 1000, 11, 1200, 13, 1400, 15, 1600]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epu32(create__m512i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epu32(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_epu32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_epu32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_epu32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mask_cvtps_epu32(create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0, 9, 0, 11, 0, 13, 0, 15, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epu32(create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epu32(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_epu32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_epu32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_epu32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mask_cvtps_epu32(create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295, 5, 4294967295, 7, 4294967295, 9, 4294967295, 11, 4294967295, 13, 4294967295, 15, 4294967295]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epu32(create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epu32(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_epu32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_epu32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_epu32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mask_cvtps_epu32(create__m512i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0, 9, 0, 11, 0, 13, 0, 15, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epu32(create__m512i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epu32(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_epu32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_epu32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mask_cvtps_epu32(create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295, 5, 4294967295, 7, 4294967295, 9, 4294967295, 11, 4294967295, 13, 4294967295, 15, 4294967295]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epu32(create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epu32(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_epu32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_epu32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mask_cvtps_epu32(create__m512i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295, 5, 4294967295, 7, 4294967295, 9, 4294967295, 11, 4294967295, 13, 4294967295, 15, 4294967295]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epu32(create__m512i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epu32(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_epu32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtps_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_maskz_cvtps_epu32(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0, 9, 0, 11, 0, 13, 0, 15, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtps_epu32(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtps_epu32(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtps_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtps_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtps_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_cvtps_epu32(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm256_cvtps_epu32(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtps_epu32(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtps_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtps_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtps_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mask_cvtps_epu32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[9, 2, 11, 4, 13, 6, 15, 8]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epu32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtps_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtps_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtps_epu32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mask_cvtps_epu32(create__m256i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967293, 5, 4294967291, 7, 4294967289]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epu32(create__m256i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtps_epu32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtps_epu32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtps_epu32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mask_cvtps_epu32(create__m256i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epu32(create__m256i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtps_epu32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtps_epu32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtps_epu32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mask_cvtps_epu32(create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epu32(create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtps_epu32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtps_epu32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtps_epu32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mask_cvtps_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295, 5, 4294967295, 7, 4294967295]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtps_epu32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtps_epu32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtps_epu32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mask_cvtps_epu32(create__m256i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epu32(create__m256i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtps_epu32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtps_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtps_epu32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mask_cvtps_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295, 5, 4294967295, 7, 4294967295]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtps_epu32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtps_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtps_epu32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mask_cvtps_epu32(create__m256i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295, 5, 4294967295, 7, 4294967295]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epu32(create__m256i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtps_epu32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtps_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtps_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_maskz_cvtps_epu32(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtps_epu32(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtps_epu32(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtps_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtps_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtps_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_cvtps_epu32(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: _mm_cvtps_epu32(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtps_epu32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtps_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtps_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtps_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvtps_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[5, 2, 7, 4]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtps_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtps_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtps_epu32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvtps_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967293]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtps_epu32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtps_epu32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtps_epu32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvtps_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 200, 3, 400]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtps_epu32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtps_epu32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtps_epu32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvtps_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtps_epu32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtps_epu32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtps_epu32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvtps_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtps_epu32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtps_epu32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtps_epu32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvtps_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtps_epu32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtps_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtps_epu32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvtps_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtps_epu32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtps_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtps_epu32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvtps_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtps_epu32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtps_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtps_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_maskz_cvtps_epu32(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtps_epu32(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtps_epu32(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtps_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtps_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtps_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_cvtps_pd(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_cvtps_pd(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtps_pd(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtps_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtps_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtps_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[9.0, 2.0, 11.0, 4.0, 13.0, 6.0, 15.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_pd(create_random__m512d(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtps_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, -1.0, 3.0, -3.0, 5.0, -5.0, 7.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_pd(create_random__m512d(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtps_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 200.0, 3.0, 400.0, 5.0, 600.0, 7.0, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_pd(create_random__m512d(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtps_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, -1.7976931348623157e308, 3.0, -1.7976931348623157e308, 5.0, -1.7976931348623157e308, 7.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_pd(create_random__m512d(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtps_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 1.7976931348623157e308, 3.0, 1.7976931348623157e308, 5.0, 1.7976931348623157e308, 7.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_pd(create_random__m512d(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtps_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_pd(create_random__m512d(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtps_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, f64::NAN, 3.0, f64::NAN, 5.0, f64::NAN, 7.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_pd(create_random__m512d(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtps_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtps_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY, 3.0, 1.1125369292536007e-308, 5.0, -f64::INFINITY, 7.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_pd(create_random__m512d(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtps_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtps_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtps_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_cvtps_pd(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtps_pd(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtps_pd(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtps_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtps_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtpslo_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_cvtpslo_pd(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_cvtpslo_pd(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtpslo_pd(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtpslo_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtpslo_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpslo_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtpslo_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_float_array_equality(&result, &[9.0, 2.0, 11.0, 4.0, 13.0, 6.0, 15.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpslo_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpslo_pd(create_random__m512d(), create_random__mmask8(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpslo_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpslo_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpslo_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtpslo_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.0, -1.0, 3.0, -3.0, 5.0, -5.0, 7.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpslo_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpslo_pd(create_random__m512d(), create_random__mmask8(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpslo_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpslo_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpslo_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtpslo_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.0, 200.0, 3.0, 400.0, 5.0, 600.0, 7.0, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpslo_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpslo_pd(create_random__m512d(), create_random__mmask8(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpslo_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpslo_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpslo_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtpslo_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.0, -1.7976931348623157e308, 3.0, -1.7976931348623157e308, 5.0, -1.7976931348623157e308, 7.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpslo_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpslo_pd(create_random__m512d(), create_random__mmask8(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpslo_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpslo_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpslo_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtpslo_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.0, 1.7976931348623157e308, 3.0, 1.7976931348623157e308, 5.0, 1.7976931348623157e308, 7.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpslo_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpslo_pd(create_random__m512d(), create_random__mmask8(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpslo_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpslo_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpslo_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtpslo_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpslo_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpslo_pd(create_random__m512d(), create_random__mmask8(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpslo_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpslo_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpslo_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtpslo_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.0, f64::NAN, 3.0, f64::NAN, 5.0, f64::NAN, 7.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpslo_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpslo_pd(create_random__m512d(), create_random__mmask8(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpslo_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpslo_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpslo_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtpslo_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY, 3.0, 1.1125369292536007e-308, 5.0, -f64::INFINITY, 7.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpslo_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpslo_pd(create_random__m512d(), create_random__mmask8(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpslo_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpslo_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtpd_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_cvtpd_ps(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_cvtpd_ps(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtpd_ps(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtpd_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtpd_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtpd_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[9.0, 2.0, 11.0, 4.0, 13.0, 6.0, 15.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_ps(create_random__m256(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtpd_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, -1.0, 3.0, -3.0, 5.0, -5.0, 7.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_ps(create_random__m256(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtpd_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 200.0, 3.0, 400.0, 5.0, 600.0, 7.0, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_ps(create_random__m256(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtpd_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, -3.4028235e38, 3.0, -3.4028235e38, 5.0, -3.4028235e38, 7.0, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_ps(create_random__m256(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtpd_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 3.4028235e38, 3.0, 3.4028235e38, 5.0, 3.4028235e38, 7.0, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_ps(create_random__m256(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtpd_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_ps(create_random__m256(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtpd_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, f32::NAN, 3.0, f32::NAN, 5.0, f32::NAN, 7.0, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_ps(create_random__m256(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtpd_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, 3.0, 5.877472e-39, 5.0, -f32::INFINITY, 7.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_ps(create_random__m256(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtpd_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_maskz_cvtpd_ps(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtpd_ps(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtpd_ps(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtpd_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtpd_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtpd_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 7.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_ps(create_random__m128(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtpd_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, -1.0, 3.0, -3.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_ps(create_random__m128(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtpd_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 200.0, 3.0, 400.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_ps(create_random__m128(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtpd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, -3.4028235e38, 3.0, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_ps(create_random__m128(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtpd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 3.4028235e38, 3.0, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_ps(create_random__m128(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtpd_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_ps(create_random__m128(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtpd_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, f32::NAN, 3.0, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_ps(create_random__m128(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtpd_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, 3.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_ps(create_random__m128(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtpd_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_maskz_cvtpd_ps(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtpd_ps(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtpd_ps(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtpd_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtpd_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpd_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_ps(create_random__m128(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpd_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, -1.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_ps(create_random__m128(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpd_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 200.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_ps(create_random__m128(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, -3.4028235e38, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_ps(create_random__m128(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 3.4028235e38, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_ps(create_random__m128(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpd_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_ps(create_random__m128(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpd_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, f32::NAN, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_ps(create_random__m128(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpd_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_ps(create_random__m128(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtpd_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_cvtpd_ps(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtpd_ps(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtpd_ps(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtpd_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtpd_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtpd_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_cvtpd_epi32(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm512_cvtpd_epi32(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtpd_epi32(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtpd_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtpd_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtpd_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[9, 2, 11, 4, 13, 6, 15, 8]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtpd_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -1, 3, -3, 5, -5, 7, -7]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtpd_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtpd_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -2147483648, 3, -2147483648, 5, -2147483648, 7, -2147483648]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtpd_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2147483647, 3, 2147483647, 5, 2147483647, 7, 2147483647]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtpd_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtpd_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -1, 3, -1, 5, -1, 7, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtpd_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2147483647, 3, -1, 5, 2147483647, 7, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtpd_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_maskz_cvtpd_epi32(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtpd_epi32(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtpd_epi32(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtpd_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtpd_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtpd_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[5, 2, 7, 4]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_epi32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtpd_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, -1, 3, -3]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_epi32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtpd_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 200, 3, 400]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_epi32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtpd_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, -2147483648, 3, -2147483648]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_epi32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtpd_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2147483647, 3, 2147483647]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_epi32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtpd_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_epi32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtpd_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, -1, 3, -1]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_epi32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtpd_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2147483647, 3, -1]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtpd_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtpd_epi32(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtpd_epi32(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtpd_epi32(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtpd_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtpd_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtpd_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128d_from([5.0, 6.0])));
        check_array_equality(&result, &[5, 2, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtpd_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, -1, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtpd_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 200, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtpd_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, -2147483648, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtpd_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2147483647, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtpd_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtpd_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, -1, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtpd_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2147483647, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtpd_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtpd_epi32(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtpd_epi32(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtpd_epi32(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtpd_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtpd_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtpd_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_cvtpd_epu32(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm512_cvtpd_epu32(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtpd_epu32(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_cvtpd_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_cvtpd_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_mask_cvtpd_epu32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[9, 2, 11, 4, 13, 6, 15, 8]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epu32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epu32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_epu32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_mask_cvtpd_epu32(create__m256i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967293, 5, 4294967291, 7, 4294967289]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epu32(create__m256i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epu32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_epu32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_epu32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_epu32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_mask_cvtpd_epu32(create__m256i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epu32(create__m256i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epu32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_epu32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_epu32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_epu32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_mask_cvtpd_epu32(create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epu32(create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epu32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_epu32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_epu32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_epu32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_mask_cvtpd_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295, 5, 4294967295, 7, 4294967295]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epu32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_epu32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_epu32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_epu32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_mask_cvtpd_epu32(create__m256i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epu32(create__m256i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epu32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_epu32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_epu32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_mask_cvtpd_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295, 5, 4294967295, 7, 4294967295]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epu32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_epu32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtpd_epu32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_mask_cvtpd_epu32(create__m256i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295, 5, 4294967295, 7, 4294967295]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epu32(create__m256i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epu32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtpd_epu32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtpd_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtpd_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm512_maskz_cvtpd_epu32(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtpd_epu32(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtpd_epu32(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtpd_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtpd_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_cvtpd_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_cvtpd_epu32(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: _mm256_cvtpd_epu32(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtpd_epu32(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_cvtpd_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_cvtpd_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_mask_cvtpd_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[5, 2, 7, 4]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_epu32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_mask_cvtpd_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967293]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_epu32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_epu32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_epu32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_mask_cvtpd_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 200, 3, 400]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_epu32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_epu32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_epu32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_mask_cvtpd_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_epu32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_epu32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_epu32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_mask_cvtpd_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_epu32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_epu32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_epu32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_mask_cvtpd_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_epu32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_epu32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_mask_cvtpd_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_epu32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtpd_epu32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_mask_cvtpd_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 4294967295, 3, 4294967295]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtpd_epu32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtpd_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtpd_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm256_maskz_cvtpd_epu32(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtpd_epu32(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtpd_epu32(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtpd_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtpd_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_cvtpd_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_cvtpd_epu32(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtpd_epu32(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtpd_epu32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_cvtpd_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_cvtpd_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvtpd_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128d_from([5.0, 6.0])));
        check_array_equality(&result, &[5, 2, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_epu32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvtpd_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 4294967295, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_epu32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_epu32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_epu32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvtpd_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 200, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_epu32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_epu32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_epu32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvtpd_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_epu32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_epu32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_epu32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvtpd_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 4294967295, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_epu32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_epu32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_epu32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvtpd_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_epu32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_epu32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvtpd_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 4294967295, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_epu32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtpd_epu32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_cvtpd_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 4294967295, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtpd_epu32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtpd_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtpd_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_maskz_cvtpd_epu32(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtpd_epu32(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtpd_epu32(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtpd_epu32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtpd_epu32_impl() }
}
