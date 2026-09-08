#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvt_roundepi64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_cvt_roundepi64_pd::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 17179869187.0, 25769803781.0, 34359738375.0, 42949672969.0, 51539607563.0, 60129542157.0, 68719476751.0]).map_err(|e| format!("{e} | call: _mm512_cvt_roundepi64_pd::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvt_roundepi64_pd::<8>(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvt_roundepi64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_cvt_roundepi64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvt_roundepi64_pd::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[42949672969.0, 2.0, 60129542157.0, 4.0, 77309411345.0, 6.0, 94489280533.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepi64_pd::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepi64_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvt_roundepi64_pd::<8>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, -1.0, 25769803781.0, -3.0, 42949672969.0, -5.0, 60129542157.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepi64_pd::<8>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepi64_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvt_roundepi64_pd::<8>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 200.0, 25769803781.0, 400.0, 42949672969.0, 600.0, 60129542157.0, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepi64_pd::<8>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepi64_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvt_roundepi64_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, -1.7976931348623157e308, 25769803781.0, -1.7976931348623157e308, 42949672969.0, -1.7976931348623157e308, 60129542157.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepi64_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepi64_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvt_roundepi64_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 1.7976931348623157e308, 25769803781.0, 1.7976931348623157e308, 42949672969.0, 1.7976931348623157e308, 60129542157.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepi64_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepi64_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvt_roundepi64_pd::<8>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 0.0, 25769803781.0, 0.0, 42949672969.0, 0.0, 60129542157.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepi64_pd::<8>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepi64_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvt_roundepi64_pd::<8>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, f64::NAN, 25769803781.0, f64::NAN, 42949672969.0, f64::NAN, 60129542157.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepi64_pd::<8>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepi64_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvt_roundepi64_pd::<8>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, -f64::INFINITY, 25769803781.0, 1.1125369292536007e-308, 42949672969.0, -f64::INFINITY, 60129542157.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepi64_pd::<8>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepi64_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepi64_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvt_roundepi64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_cvt_roundepi64_pd::<8>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 0.0, 25769803781.0, 0.0, 42949672969.0, 0.0, 60129542157.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvt_roundepi64_pd::<8>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvt_roundepi64_pd::<8>(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvt_roundepi64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvt_roundepi64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_cvtepi64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtepi64_pd(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589934593.0, 17179869187.0]).map_err(|e| format!("{e} | call: _mm_cvtepi64_pd(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtepi64_pd(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_cvtepi64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_cvtepi64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepi64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtepi64_pd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([3, 4, 5, 6])));
        check_float_array_equality(&result, &[17179869187.0, 2.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepi64_pd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([3, 4, 5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi64_pd(create_random__m128d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepi64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepi64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepi64_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtepi64_pd(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589934593.0, -1.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepi64_pd(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi64_pd(create_random__m128d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepi64_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepi64_pd_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepi64_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtepi64_pd(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589934593.0, 200.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepi64_pd(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi64_pd(create_random__m128d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepi64_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepi64_pd_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepi64_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtepi64_pd(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589934593.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_cvtepi64_pd(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi64_pd(create_random__m128d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepi64_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepi64_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepi64_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtepi64_pd(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589934593.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_cvtepi64_pd(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi64_pd(create_random__m128d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepi64_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepi64_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepi64_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtepi64_pd(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589934593.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepi64_pd(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi64_pd(create_random__m128d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepi64_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepi64_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepi64_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtepi64_pd(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589934593.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm_mask_cvtepi64_pd(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi64_pd(create_random__m128d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepi64_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepi64_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepi64_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtepi64_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589934593.0, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_mask_cvtepi64_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi64_pd(create_random__m128d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepi64_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepi64_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_maskz_cvtepi64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_cvtepi64_pd(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589934593.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtepi64_pd(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtepi64_pd(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_maskz_cvtepi64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_maskz_cvtepi64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_cvtepi64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_cvtepi64_pd(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589934593.0, 17179869187.0, 25769803781.0, 34359738375.0]).map_err(|e| format!("{e} | call: _mm256_cvtepi64_pd(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtepi64_pd(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_cvtepi64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_cvtepi64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepi64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtepi64_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12])));
        check_float_array_equality(&result, &[25769803781.0, 2.0, 42949672969.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepi64_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi64_pd(create_random__m256d(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepi64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepi64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepi64_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtepi64_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589934593.0, -1.0, 25769803781.0, -3.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepi64_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi64_pd(create_random__m256d(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepi64_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepi64_pd_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepi64_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtepi64_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589934593.0, 200.0, 25769803781.0, 400.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepi64_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi64_pd(create_random__m256d(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepi64_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepi64_pd_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepi64_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtepi64_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589934593.0, -1.7976931348623157e308, 25769803781.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepi64_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi64_pd(create_random__m256d(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepi64_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepi64_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepi64_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtepi64_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589934593.0, 1.7976931348623157e308, 25769803781.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepi64_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi64_pd(create_random__m256d(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepi64_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepi64_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepi64_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtepi64_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589934593.0, 0.0, 25769803781.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepi64_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi64_pd(create_random__m256d(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepi64_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepi64_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepi64_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtepi64_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589934593.0, f64::NAN, 25769803781.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepi64_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi64_pd(create_random__m256d(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepi64_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepi64_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepi64_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtepi64_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589934593.0, -f64::INFINITY, 25769803781.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepi64_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi64_pd(create_random__m256d(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepi64_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepi64_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_cvtepi64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_cvtepi64_pd(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589934593.0, 0.0, 25769803781.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtepi64_pd(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtepi64_pd(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_maskz_cvtepi64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_maskz_cvtepi64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvtepi64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_cvtepi64_pd(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 17179869187.0, 25769803781.0, 34359738375.0, 42949672969.0, 51539607563.0, 60129542157.0, 68719476751.0]).map_err(|e| format!("{e} | call: _mm512_cvtepi64_pd(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtepi64_pd(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvtepi64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_cvtepi64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepi64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepi64_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[42949672969.0, 2.0, 60129542157.0, 4.0, 77309411345.0, 6.0, 94489280533.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepi64_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi64_pd(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepi64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepi64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepi64_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepi64_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, -1.0, 25769803781.0, -3.0, 42949672969.0, -5.0, 60129542157.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepi64_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi64_pd(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepi64_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepi64_pd_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepi64_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepi64_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 200.0, 25769803781.0, 400.0, 42949672969.0, 600.0, 60129542157.0, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepi64_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi64_pd(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepi64_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepi64_pd_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepi64_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepi64_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, -1.7976931348623157e308, 25769803781.0, -1.7976931348623157e308, 42949672969.0, -1.7976931348623157e308, 60129542157.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepi64_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi64_pd(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepi64_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepi64_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepi64_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepi64_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 1.7976931348623157e308, 25769803781.0, 1.7976931348623157e308, 42949672969.0, 1.7976931348623157e308, 60129542157.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepi64_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi64_pd(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepi64_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepi64_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepi64_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepi64_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 0.0, 25769803781.0, 0.0, 42949672969.0, 0.0, 60129542157.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepi64_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi64_pd(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepi64_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepi64_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepi64_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepi64_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, f64::NAN, 25769803781.0, f64::NAN, 42949672969.0, f64::NAN, 60129542157.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepi64_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi64_pd(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepi64_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepi64_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepi64_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepi64_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, -f64::INFINITY, 25769803781.0, 1.1125369292536007e-308, 42949672969.0, -f64::INFINITY, 60129542157.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepi64_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi64_pd(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepi64_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepi64_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvtepi64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_cvtepi64_pd(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 0.0, 25769803781.0, 0.0, 42949672969.0, 0.0, 60129542157.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtepi64_pd(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtepi64_pd(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtepi64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvtepi64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvt_roundepi64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_cvt_roundepi64_ps::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 17179870000.0, 25769804000.0, 34359740000.0, 42949673000.0, 51539608000.0, 60129542000.0, 68719480000.0]).map_err(|e| format!("{e} | call: _mm512_cvt_roundepi64_ps::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvt_roundepi64_ps::<8>(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvt_roundepi64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_cvt_roundepi64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvt_roundepi64_ps::<8>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[42949673000.0, 2.0, 60129542000.0, 4.0, 77309410000.0, 6.0, 94489280000.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepi64_ps::<8>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepi64_ps::<8>(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvt_roundepi64_ps::<8>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, -1.0, 25769804000.0, -3.0, 42949673000.0, -5.0, 60129542000.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepi64_ps::<8>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepi64_ps::<8>(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvt_roundepi64_ps::<8>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 200.0, 25769804000.0, 400.0, 42949673000.0, 600.0, 60129542000.0, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepi64_ps::<8>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepi64_ps::<8>(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvt_roundepi64_ps::<8>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, -3.4028235e38, 25769804000.0, -3.4028235e38, 42949673000.0, -3.4028235e38, 60129542000.0, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepi64_ps::<8>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepi64_ps::<8>(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvt_roundepi64_ps::<8>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 3.4028235e38, 25769804000.0, 3.4028235e38, 42949673000.0, 3.4028235e38, 60129542000.0, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepi64_ps::<8>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepi64_ps::<8>(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvt_roundepi64_ps::<8>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 0.0, 25769804000.0, 0.0, 42949673000.0, 0.0, 60129542000.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepi64_ps::<8>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepi64_ps::<8>(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvt_roundepi64_ps::<8>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, f32::NAN, 25769804000.0, f32::NAN, 42949673000.0, f32::NAN, 60129542000.0, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepi64_ps::<8>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepi64_ps::<8>(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvt_roundepi64_ps::<8>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, -f32::INFINITY, 25769804000.0, 5.877472e-39, 42949673000.0, -f32::INFINITY, 60129542000.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepi64_ps::<8>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepi64_ps::<8>(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepi64_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvt_roundepi64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_maskz_cvt_roundepi64_ps::<8>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 0.0, 25769804000.0, 0.0, 42949673000.0, 0.0, 60129542000.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvt_roundepi64_ps::<8>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvt_roundepi64_ps::<8>(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvt_roundepi64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvt_roundepi64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_cvtepi64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtepi64_ps(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589935000.0, 17179870000.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cvtepi64_ps(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtepi64_ps(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_cvtepi64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_cvtepi64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepi64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtepi64_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_float_array_equality(&result, &[25769804000.0, 2.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepi64_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi64_ps(create_random__m128(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepi64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepi64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepi64_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtepi64_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589935000.0, -1.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepi64_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi64_ps(create_random__m128(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepi64_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepi64_ps_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepi64_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtepi64_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589935000.0, 200.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepi64_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi64_ps(create_random__m128(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepi64_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepi64_ps_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepi64_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtepi64_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589935000.0, -3.4028235e38, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepi64_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi64_ps(create_random__m128(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepi64_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepi64_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepi64_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtepi64_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589935000.0, 3.4028235e38, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepi64_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi64_ps(create_random__m128(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepi64_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepi64_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepi64_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtepi64_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589935000.0, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepi64_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi64_ps(create_random__m128(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepi64_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepi64_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepi64_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtepi64_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589935000.0, f32::NAN, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepi64_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi64_ps(create_random__m128(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepi64_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepi64_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepi64_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtepi64_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589935000.0, -f32::INFINITY, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepi64_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi64_ps(create_random__m128(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepi64_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepi64_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_maskz_cvtepi64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_cvtepi64_ps(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589935000.0, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtepi64_ps(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtepi64_ps(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_maskz_cvtepi64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_maskz_cvtepi64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_cvtepi64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_cvtepi64_ps(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589935000.0, 17179870000.0, 25769804000.0, 34359740000.0]).map_err(|e| format!("{e} | call: _mm256_cvtepi64_ps(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtepi64_ps(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_cvtepi64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_cvtepi64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepi64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtepi64_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12])));
        check_float_array_equality(&result, &[25769804000.0, 2.0, 42949673000.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepi64_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi64_ps(create_random__m128(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepi64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepi64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepi64_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtepi64_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589935000.0, -1.0, 25769804000.0, -3.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepi64_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi64_ps(create_random__m128(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepi64_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepi64_ps_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepi64_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtepi64_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589935000.0, 200.0, 25769804000.0, 400.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepi64_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi64_ps(create_random__m128(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepi64_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepi64_ps_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepi64_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtepi64_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589935000.0, -3.4028235e38, 25769804000.0, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepi64_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi64_ps(create_random__m128(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepi64_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepi64_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepi64_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtepi64_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589935000.0, 3.4028235e38, 25769804000.0, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepi64_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi64_ps(create_random__m128(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepi64_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepi64_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepi64_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtepi64_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589935000.0, 0.0, 25769804000.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepi64_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi64_ps(create_random__m128(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepi64_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepi64_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepi64_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtepi64_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589935000.0, f32::NAN, 25769804000.0, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepi64_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi64_ps(create_random__m128(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepi64_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepi64_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepi64_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtepi64_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589935000.0, -f32::INFINITY, 25769804000.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepi64_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi64_ps(create_random__m128(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepi64_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepi64_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_cvtepi64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_maskz_cvtepi64_ps(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589935000.0, 0.0, 25769804000.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtepi64_ps(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtepi64_ps(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_maskz_cvtepi64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_maskz_cvtepi64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvtepi64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_cvtepi64_ps(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 17179870000.0, 25769804000.0, 34359740000.0, 42949673000.0, 51539608000.0, 60129542000.0, 68719480000.0]).map_err(|e| format!("{e} | call: _mm512_cvtepi64_ps(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtepi64_ps(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvtepi64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_cvtepi64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepi64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtepi64_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[42949673000.0, 2.0, 60129542000.0, 4.0, 77309410000.0, 6.0, 94489280000.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepi64_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi64_ps(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepi64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepi64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepi64_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtepi64_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, -1.0, 25769804000.0, -3.0, 42949673000.0, -5.0, 60129542000.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepi64_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi64_ps(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepi64_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepi64_ps_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepi64_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtepi64_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 200.0, 25769804000.0, 400.0, 42949673000.0, 600.0, 60129542000.0, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepi64_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi64_ps(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepi64_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepi64_ps_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepi64_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtepi64_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, -3.4028235e38, 25769804000.0, -3.4028235e38, 42949673000.0, -3.4028235e38, 60129542000.0, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepi64_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi64_ps(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepi64_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepi64_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepi64_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtepi64_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 3.4028235e38, 25769804000.0, 3.4028235e38, 42949673000.0, 3.4028235e38, 60129542000.0, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepi64_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi64_ps(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepi64_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepi64_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepi64_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtepi64_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 0.0, 25769804000.0, 0.0, 42949673000.0, 0.0, 60129542000.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepi64_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi64_ps(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepi64_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepi64_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepi64_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtepi64_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, f32::NAN, 25769804000.0, f32::NAN, 42949673000.0, f32::NAN, 60129542000.0, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepi64_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi64_ps(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepi64_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepi64_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepi64_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtepi64_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, -f32::INFINITY, 25769804000.0, 5.877472e-39, 42949673000.0, -f32::INFINITY, 60129542000.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepi64_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi64_ps(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepi64_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepi64_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvtepi64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_maskz_cvtepi64_ps(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 0.0, 25769804000.0, 0.0, 42949673000.0, 0.0, 60129542000.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtepi64_ps(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtepi64_ps(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtepi64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvtepi64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvt_roundepu64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_cvt_roundepu64_pd::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 17179869187.0, 25769803781.0, 34359738375.0, 42949672969.0, 51539607563.0, 60129542157.0, 68719476751.0]).map_err(|e| format!("{e} | call: _mm512_cvt_roundepu64_pd::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvt_roundepu64_pd::<8>(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvt_roundepu64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_cvt_roundepu64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvt_roundepu64_pd::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[42949672969.0, 2.0, 60129542157.0, 4.0, 77309411345.0, 6.0, 94489280533.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepu64_pd::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepu64_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvt_roundepu64_pd::<8>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, -1.0, 25769803781.0, -3.0, 42949672969.0, -5.0, 60129542157.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepu64_pd::<8>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepu64_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvt_roundepu64_pd::<8>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 200.0, 25769803781.0, 400.0, 42949672969.0, 600.0, 60129542157.0, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepu64_pd::<8>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepu64_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvt_roundepu64_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, -1.7976931348623157e308, 25769803781.0, -1.7976931348623157e308, 42949672969.0, -1.7976931348623157e308, 60129542157.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepu64_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepu64_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvt_roundepu64_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 1.7976931348623157e308, 25769803781.0, 1.7976931348623157e308, 42949672969.0, 1.7976931348623157e308, 60129542157.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepu64_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepu64_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvt_roundepu64_pd::<8>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 0.0, 25769803781.0, 0.0, 42949672969.0, 0.0, 60129542157.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepu64_pd::<8>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepu64_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvt_roundepu64_pd::<8>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, f64::NAN, 25769803781.0, f64::NAN, 42949672969.0, f64::NAN, 60129542157.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepu64_pd::<8>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepu64_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvt_roundepu64_pd::<8>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, -f64::INFINITY, 25769803781.0, 1.1125369292536007e-308, 42949672969.0, -f64::INFINITY, 60129542157.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepu64_pd::<8>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepu64_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepu64_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvt_roundepu64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_cvt_roundepu64_pd::<8>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 0.0, 25769803781.0, 0.0, 42949672969.0, 0.0, 60129542157.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvt_roundepu64_pd::<8>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvt_roundepu64_pd::<8>(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvt_roundepu64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvt_roundepu64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_cvtepu64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtepu64_pd(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589934593.0, 17179869187.0]).map_err(|e| format!("{e} | call: _mm_cvtepu64_pd(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtepu64_pd(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_cvtepu64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_cvtepu64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepu64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtepu64_pd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([3, 4, 5, 6])));
        check_float_array_equality(&result, &[17179869187.0, 2.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepu64_pd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([3, 4, 5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepu64_pd(create_random__m128d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepu64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepu64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepu64_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtepu64_pd(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589934593.0, -1.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepu64_pd(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepu64_pd(create_random__m128d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepu64_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepu64_pd_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepu64_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtepu64_pd(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589934593.0, 200.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepu64_pd(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepu64_pd(create_random__m128d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepu64_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepu64_pd_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepu64_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtepu64_pd(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589934593.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_cvtepu64_pd(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepu64_pd(create_random__m128d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepu64_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepu64_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepu64_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtepu64_pd(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589934593.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_cvtepu64_pd(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepu64_pd(create_random__m128d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepu64_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepu64_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepu64_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtepu64_pd(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589934593.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepu64_pd(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepu64_pd(create_random__m128d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepu64_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepu64_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepu64_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtepu64_pd(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589934593.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm_mask_cvtepu64_pd(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepu64_pd(create_random__m128d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepu64_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepu64_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepu64_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtepu64_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589934593.0, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_mask_cvtepu64_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepu64_pd(create_random__m128d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepu64_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepu64_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_maskz_cvtepu64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_cvtepu64_pd(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589934593.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtepu64_pd(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtepu64_pd(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_maskz_cvtepu64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_maskz_cvtepu64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_cvtepu64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_cvtepu64_pd(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589934593.0, 17179869187.0, 25769803781.0, 34359738375.0]).map_err(|e| format!("{e} | call: _mm256_cvtepu64_pd(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtepu64_pd(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_cvtepu64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_cvtepu64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepu64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtepu64_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12])));
        check_float_array_equality(&result, &[25769803781.0, 2.0, 42949672969.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepu64_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepu64_pd(create_random__m256d(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepu64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepu64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepu64_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtepu64_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589934593.0, -1.0, 25769803781.0, -3.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepu64_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepu64_pd(create_random__m256d(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepu64_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepu64_pd_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepu64_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtepu64_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589934593.0, 200.0, 25769803781.0, 400.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepu64_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepu64_pd(create_random__m256d(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepu64_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepu64_pd_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepu64_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtepu64_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589934593.0, -1.7976931348623157e308, 25769803781.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepu64_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepu64_pd(create_random__m256d(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepu64_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepu64_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepu64_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtepu64_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589934593.0, 1.7976931348623157e308, 25769803781.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepu64_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepu64_pd(create_random__m256d(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepu64_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepu64_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepu64_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtepu64_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589934593.0, 0.0, 25769803781.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepu64_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepu64_pd(create_random__m256d(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepu64_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepu64_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepu64_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtepu64_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589934593.0, f64::NAN, 25769803781.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepu64_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepu64_pd(create_random__m256d(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepu64_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepu64_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepu64_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtepu64_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589934593.0, -f64::INFINITY, 25769803781.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepu64_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepu64_pd(create_random__m256d(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepu64_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepu64_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_cvtepu64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_cvtepu64_pd(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589934593.0, 0.0, 25769803781.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtepu64_pd(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtepu64_pd(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_maskz_cvtepu64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_maskz_cvtepu64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvtepu64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_cvtepu64_pd(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 17179869187.0, 25769803781.0, 34359738375.0, 42949672969.0, 51539607563.0, 60129542157.0, 68719476751.0]).map_err(|e| format!("{e} | call: _mm512_cvtepu64_pd(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtepu64_pd(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvtepu64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_cvtepu64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepu64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepu64_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[42949672969.0, 2.0, 60129542157.0, 4.0, 77309411345.0, 6.0, 94489280533.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepu64_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu64_pd(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepu64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepu64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepu64_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepu64_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, -1.0, 25769803781.0, -3.0, 42949672969.0, -5.0, 60129542157.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepu64_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu64_pd(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepu64_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepu64_pd_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepu64_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepu64_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 200.0, 25769803781.0, 400.0, 42949672969.0, 600.0, 60129542157.0, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepu64_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu64_pd(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepu64_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepu64_pd_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepu64_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepu64_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, -1.7976931348623157e308, 25769803781.0, -1.7976931348623157e308, 42949672969.0, -1.7976931348623157e308, 60129542157.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepu64_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu64_pd(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepu64_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepu64_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepu64_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepu64_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 1.7976931348623157e308, 25769803781.0, 1.7976931348623157e308, 42949672969.0, 1.7976931348623157e308, 60129542157.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepu64_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu64_pd(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepu64_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepu64_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepu64_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepu64_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 0.0, 25769803781.0, 0.0, 42949672969.0, 0.0, 60129542157.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepu64_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu64_pd(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepu64_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepu64_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepu64_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepu64_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, f64::NAN, 25769803781.0, f64::NAN, 42949672969.0, f64::NAN, 60129542157.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepu64_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu64_pd(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepu64_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepu64_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepu64_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepu64_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, -f64::INFINITY, 25769803781.0, 1.1125369292536007e-308, 42949672969.0, -f64::INFINITY, 60129542157.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepu64_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu64_pd(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepu64_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepu64_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvtepu64_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_cvtepu64_pd(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589934593.0, 0.0, 25769803781.0, 0.0, 42949672969.0, 0.0, 60129542157.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtepu64_pd(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtepu64_pd(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtepu64_pd() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvtepu64_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvt_roundepu64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_cvt_roundepu64_ps::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 17179870000.0, 25769804000.0, 34359740000.0, 42949673000.0, 51539608000.0, 60129542000.0, 68719480000.0]).map_err(|e| format!("{e} | call: _mm512_cvt_roundepu64_ps::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvt_roundepu64_ps::<8>(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvt_roundepu64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_cvt_roundepu64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvt_roundepu64_ps::<8>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[42949673000.0, 2.0, 60129542000.0, 4.0, 77309410000.0, 6.0, 94489280000.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepu64_ps::<8>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepu64_ps::<8>(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvt_roundepu64_ps::<8>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, -1.0, 25769804000.0, -3.0, 42949673000.0, -5.0, 60129542000.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepu64_ps::<8>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepu64_ps::<8>(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvt_roundepu64_ps::<8>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 200.0, 25769804000.0, 400.0, 42949673000.0, 600.0, 60129542000.0, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepu64_ps::<8>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepu64_ps::<8>(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvt_roundepu64_ps::<8>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, -3.4028235e38, 25769804000.0, -3.4028235e38, 42949673000.0, -3.4028235e38, 60129542000.0, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepu64_ps::<8>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepu64_ps::<8>(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvt_roundepu64_ps::<8>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 3.4028235e38, 25769804000.0, 3.4028235e38, 42949673000.0, 3.4028235e38, 60129542000.0, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepu64_ps::<8>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepu64_ps::<8>(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvt_roundepu64_ps::<8>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 0.0, 25769804000.0, 0.0, 42949673000.0, 0.0, 60129542000.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepu64_ps::<8>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepu64_ps::<8>(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvt_roundepu64_ps::<8>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, f32::NAN, 25769804000.0, f32::NAN, 42949673000.0, f32::NAN, 60129542000.0, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepu64_ps::<8>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepu64_ps::<8>(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvt_roundepu64_ps::<8>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, -f32::INFINITY, 25769804000.0, 5.877472e-39, 42949673000.0, -f32::INFINITY, 60129542000.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundepu64_ps::<8>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundepu64_ps::<8>(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundepu64_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvt_roundepu64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_maskz_cvt_roundepu64_ps::<8>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 0.0, 25769804000.0, 0.0, 42949673000.0, 0.0, 60129542000.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvt_roundepu64_ps::<8>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvt_roundepu64_ps::<8>(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvt_roundepu64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvt_roundepu64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_cvtepu64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtepu64_ps(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589935000.0, 17179870000.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cvtepu64_ps(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtepu64_ps(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_cvtepu64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_cvtepu64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepu64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtepu64_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_float_array_equality(&result, &[25769804000.0, 2.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepu64_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepu64_ps(create_random__m128(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepu64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepu64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepu64_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtepu64_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589935000.0, -1.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepu64_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepu64_ps(create_random__m128(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepu64_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepu64_ps_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepu64_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtepu64_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589935000.0, 200.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepu64_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepu64_ps(create_random__m128(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepu64_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepu64_ps_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepu64_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtepu64_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589935000.0, -3.4028235e38, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepu64_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepu64_ps(create_random__m128(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepu64_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepu64_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepu64_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtepu64_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589935000.0, 3.4028235e38, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepu64_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepu64_ps(create_random__m128(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepu64_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepu64_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepu64_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtepu64_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589935000.0, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepu64_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepu64_ps(create_random__m128(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepu64_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepu64_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepu64_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtepu64_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589935000.0, f32::NAN, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepu64_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepu64_ps(create_random__m128(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepu64_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepu64_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtepu64_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtepu64_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589935000.0, -f32::INFINITY, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_cvtepu64_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepu64_ps(create_random__m128(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtepu64_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtepu64_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_maskz_cvtepu64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_cvtepu64_ps(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[8589935000.0, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtepu64_ps(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtepu64_ps(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_maskz_cvtepu64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_maskz_cvtepu64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_cvtepu64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_cvtepu64_ps(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589935000.0, 17179870000.0, 25769804000.0, 34359740000.0]).map_err(|e| format!("{e} | call: _mm256_cvtepu64_ps(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtepu64_ps(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_cvtepu64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_cvtepu64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepu64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtepu64_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12])));
        check_float_array_equality(&result, &[25769804000.0, 2.0, 42949673000.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepu64_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepu64_ps(create_random__m128(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepu64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepu64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepu64_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtepu64_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589935000.0, -1.0, 25769804000.0, -3.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepu64_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepu64_ps(create_random__m128(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepu64_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepu64_ps_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepu64_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtepu64_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589935000.0, 200.0, 25769804000.0, 400.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepu64_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepu64_ps(create_random__m128(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepu64_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepu64_ps_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepu64_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtepu64_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589935000.0, -3.4028235e38, 25769804000.0, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepu64_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepu64_ps(create_random__m128(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepu64_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepu64_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepu64_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtepu64_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589935000.0, 3.4028235e38, 25769804000.0, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepu64_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepu64_ps(create_random__m128(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepu64_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepu64_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepu64_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtepu64_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589935000.0, 0.0, 25769804000.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepu64_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepu64_ps(create_random__m128(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepu64_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepu64_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepu64_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtepu64_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589935000.0, f32::NAN, 25769804000.0, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepu64_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepu64_ps(create_random__m128(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepu64_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepu64_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtepu64_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_mask_cvtepu64_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589935000.0, -f32::INFINITY, 25769804000.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_mask_cvtepu64_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepu64_ps(create_random__m128(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtepu64_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtepu64_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_cvtepu64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_maskz_cvtepu64_ps(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[8589935000.0, 0.0, 25769804000.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtepu64_ps(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtepu64_ps(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_maskz_cvtepu64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_maskz_cvtepu64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvtepu64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_cvtepu64_ps(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 17179870000.0, 25769804000.0, 34359740000.0, 42949673000.0, 51539608000.0, 60129542000.0, 68719480000.0]).map_err(|e| format!("{e} | call: _mm512_cvtepu64_ps(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtepu64_ps(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvtepu64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_cvtepu64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepu64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtepu64_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[42949673000.0, 2.0, 60129542000.0, 4.0, 77309410000.0, 6.0, 94489280000.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepu64_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu64_ps(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepu64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepu64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepu64_ps_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtepu64_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, -1.0, 25769804000.0, -3.0, 42949673000.0, -5.0, 60129542000.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepu64_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu64_ps(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepu64_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepu64_ps_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepu64_ps_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtepu64_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 200.0, 25769804000.0, 400.0, 42949673000.0, 600.0, 60129542000.0, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepu64_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu64_ps(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepu64_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepu64_ps_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepu64_ps_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtepu64_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, -3.4028235e38, 25769804000.0, -3.4028235e38, 42949673000.0, -3.4028235e38, 60129542000.0, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepu64_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu64_ps(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepu64_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepu64_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepu64_ps_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtepu64_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 3.4028235e38, 25769804000.0, 3.4028235e38, 42949673000.0, 3.4028235e38, 60129542000.0, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepu64_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu64_ps(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepu64_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepu64_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepu64_ps_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtepu64_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 0.0, 25769804000.0, 0.0, 42949673000.0, 0.0, 60129542000.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepu64_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu64_ps(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepu64_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepu64_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepu64_ps_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtepu64_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, f32::NAN, 25769804000.0, f32::NAN, 42949673000.0, f32::NAN, 60129542000.0, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepu64_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu64_ps(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepu64_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepu64_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtepu64_ps_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_cvtepu64_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, -f32::INFINITY, 25769804000.0, 5.877472e-39, 42949673000.0, -f32::INFINITY, 60129542000.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm512_mask_cvtepu64_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu64_ps(create_random__m256(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtepu64_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtepu64_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvtepu64_ps_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_maskz_cvtepu64_ps(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8589935000.0, 0.0, 25769804000.0, 0.0, 42949673000.0, 0.0, 60129542000.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtepu64_ps(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtepu64_ps(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtepu64_ps() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvtepu64_ps_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvt_roundpd_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_cvt_roundpd_epi64::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm512_cvt_roundpd_epi64::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvt_roundpd_epi64::<8>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvt_roundpd_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_cvt_roundpd_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvt_roundpd_epi64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 17179869187, 19, 34359738375, 21, 51539607563, 23, 68719476751]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundpd_epi64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvt_roundpd_epi64::<8>(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -1, 3, -3, 5, -5, 7, -7]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundpd_epi64::<8>(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvt_roundpd_epi64::<8>(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundpd_epi64::<8>(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvt_roundpd_epi64::<8>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -9223372036854775808, 3, -9223372036854775808, 5, -9223372036854775808, 7, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundpd_epi64::<8>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvt_roundpd_epi64::<8>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 9223372036854775807, 3, 9223372036854775807, 5, 9223372036854775807, 7, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundpd_epi64::<8>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvt_roundpd_epi64::<8>(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundpd_epi64::<8>(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvt_roundpd_epi64::<8>(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -1, 3, -1, 5, -1, 7, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundpd_epi64::<8>(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvt_roundpd_epi64::<8>(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 9223372036854775807, 3, -1, 5, 9223372036854775807, 7, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundpd_epi64::<8>(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundpd_epi64_boundary_mixed_impl() }
}
