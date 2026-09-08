#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_sd_mask::<0, 8>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_sd_mask() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_sd_mask_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_sd_mask::<0, 8>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_sd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_sd_mask::<0, 8>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_sd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_sd_mask::<0, 8>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_sd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_sd_mask::<0, 8>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_sd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_sd_mask::<0, 8>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_sd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_sd_mask::<0, 8>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_sd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_sd_mask::<0, 8>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_sd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_sd_mask::<0, 8>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_sd_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_cmp_round_sd_mask::<0, 8>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cmp_round_sd_mask::<0, 8>(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cmp_round_sd_mask_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cmp_round_sd_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_ps_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_max_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_max_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_max_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_max_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_max_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_max_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_max_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_max_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_max_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_max_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_max_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_max_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_max_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_max_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_max_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_max_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_ps_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_max_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_max_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_max_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_max_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_max_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_max_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_max_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_max_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_pd_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_max_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_max_pd(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_pd_normal2_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_max_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_max_pd(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_pd_normal3_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_max_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_max_pd(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_pd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_max_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_max_pd(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_pd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_max_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_max_pd(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_pd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_max_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_max_pd(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_pd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_max_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_max_pd(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_pd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_max_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_max_pd(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_pd_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_max_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_pd_normal2_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_max_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_pd_normal3_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_max_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_max_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_max_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_max_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_max_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_max_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_ps_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_min_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_min_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_min_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_min_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_min_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_min_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_min_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_min_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_min_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_min_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_min_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_min_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_min_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_min_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_min_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_min_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_ps_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_min_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_ps() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_min_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_min_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_min_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_min_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_min_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_min_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_min_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_pd_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_min_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_min_pd(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_pd_normal2_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_min_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_min_pd(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_pd_normal3_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_min_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_min_pd(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_pd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_min_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_min_pd(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_pd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_min_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_min_pd(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_pd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_min_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_min_pd(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_pd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_min_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_min_pd(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_pd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_min_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_reduce_min_pd(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_pd_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_min_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_pd() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_pd_normal2_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_min_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_pd_normal3_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_min_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_min_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_min_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_min_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_min_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_reduce_min_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]);
        _mm512_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        _mm512_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        _mm512_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        _mm512_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]);
        _mm256_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        _mm256_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        _mm256_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        _mm256_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]);
        _mm_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]);
        _mm_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        _mm_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        _mm_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]);
        _mm_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        _mm_mask_cvtepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi32_storeu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]);
        _mm512_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        _mm512_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        _mm512_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        _mm512_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]);
        _mm256_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        _mm256_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        _mm256_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        _mm256_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]);
        _mm_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]);
        _mm_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        _mm_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        _mm_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]);
        _mm_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        _mm_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]);
        _mm512_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        _mm512_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        _mm512_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        _mm512_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]);
        _mm256_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        _mm256_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        _mm256_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        _mm256_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]);
        _mm_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]);
        _mm_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        _mm_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        _mm_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]);
        _mm_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        _mm_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]);
        _mm512_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm512_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm512_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm512_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi32_storeu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]);
        _mm256_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm256_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm256_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm256_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi32_storeu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]);
        _mm_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm_mask_cvtepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi32_storeu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]);
        _mm512_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm512_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm512_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm512_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi32_storeu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]);
        _mm256_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm256_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm256_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm256_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi32_storeu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]);
        _mm_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi32_storeu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]);
        _mm512_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm512_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm512_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm512_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi32_storeu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]);
        _mm256_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm256_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm256_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm256_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi32_storeu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]);
        _mm_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi32_storeu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]);
        _mm512_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        _mm512_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        _mm512_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        _mm512_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]);
        _mm256_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        _mm256_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        _mm256_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        _mm256_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]);
        _mm_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]);
        _mm_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        _mm_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        _mm_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]);
        _mm_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        _mm_mask_cvtepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]);
        _mm512_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        _mm512_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        _mm512_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        _mm512_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]);
        _mm256_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        _mm256_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        _mm256_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        _mm256_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]);
        _mm_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]);
        _mm_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        _mm_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        _mm_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]);
        _mm_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        _mm_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]);
        _mm512_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        _mm512_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        _mm512_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        _mm512_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]);
        _mm256_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        _mm256_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        _mm256_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        _mm256_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]);
        _mm_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]);
        _mm_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        _mm_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        _mm_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]);
        _mm_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        _mm_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]);
        _mm512_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm512_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm512_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm512_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]);
        _mm256_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm256_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm256_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm256_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]);
        _mm_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm_mask_cvtepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]);
        _mm512_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm512_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm512_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm512_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]);
        _mm256_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm256_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm256_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm256_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]);
        _mm_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtsepi64_storeu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]);
        _mm512_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm512_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm512_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm512_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtusepi64_storeu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]);
        _mm256_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm256_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm256_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm256_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtusepi64_storeu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]);
        _mm_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtusepi64_storeu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]);
        _mm512_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm512_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm512_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]);
        _mm512_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepi64_storeu_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]);
        _mm256_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm256_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm256_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]);
        _mm256_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepi64_storeu_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([0, -1, 2, -3]);
        _mm_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([100, 200, 300, 400]);
        _mm_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([-1, -1, -1, -1]);
        _mm_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]);
        _mm_mask_cvtepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepi64_storeu_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]);
        _mm512_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm512_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm512_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]);
        _mm512_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtsepi64_storeu_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]);
        _mm256_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm256_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm256_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]);
        _mm256_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtsepi64_storeu_epi32_boundary_mixed_impl() }
}
