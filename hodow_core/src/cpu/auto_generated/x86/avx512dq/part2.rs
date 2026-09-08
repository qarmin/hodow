#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvt_roundpd_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_cvt_roundpd_epi64::<8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvt_roundpd_epi64::<8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvt_roundpd_epi64::<8>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvt_roundpd_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvt_roundpd_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_cvtpd_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cvtpd_epi64(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: _mm_cvtpd_epi64(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtpd_epi64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_cvtpd_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_cvtpd_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtpd_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtpd_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128d_from([5.0, 6.0])));
        check_array_equality(&result, &[5, 17179869187]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtpd_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtpd_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtpd_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtpd_epi64(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, -1]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epi64(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtpd_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtpd_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtpd_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtpd_epi64(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 200]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epi64(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtpd_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtpd_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtpd_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtpd_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtpd_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtpd_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtpd_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtpd_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtpd_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtpd_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtpd_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtpd_epi64(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epi64(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtpd_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtpd_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtpd_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtpd_epi64(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, -1]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epi64(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtpd_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtpd_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtpd_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtpd_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtpd_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtpd_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_maskz_cvtpd_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_cvtpd_epi64(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtpd_epi64(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtpd_epi64(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_maskz_cvtpd_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_maskz_cvtpd_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_cvtpd_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cvtpd_epi64(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: _mm256_cvtpd_epi64(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtpd_epi64(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_cvtpd_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_cvtpd_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtpd_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtpd_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256d_from([9.0, 10.0, 11.0, 12.0])));
        check_array_equality(&result, &[9, 17179869187, 11, 34359738375]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256d_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtpd_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtpd_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtpd_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtpd_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, -1, 3, -3]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtpd_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtpd_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtpd_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtpd_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 200, 3, 400]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtpd_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtpd_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtpd_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtpd_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, -9223372036854775808, 3, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtpd_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtpd_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtpd_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtpd_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 9223372036854775807, 3, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtpd_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtpd_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtpd_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtpd_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtpd_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtpd_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtpd_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtpd_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, -1, 3, -1]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtpd_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtpd_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtpd_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtpd_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 9223372036854775807, 3, -1]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtpd_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtpd_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_cvtpd_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_cvtpd_epi64(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtpd_epi64(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtpd_epi64(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_maskz_cvtpd_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_maskz_cvtpd_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvtpd_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_cvtpd_epi64(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm512_cvtpd_epi64(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtpd_epi64(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvtpd_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_cvtpd_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtpd_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtpd_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 17179869187, 19, 34359738375, 21, 51539607563, 23, 68719476751]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtpd_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtpd_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtpd_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtpd_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -1, 3, -3, 5, -5, 7, -7]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtpd_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtpd_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtpd_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtpd_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtpd_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtpd_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtpd_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtpd_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -9223372036854775808, 3, -9223372036854775808, 5, -9223372036854775808, 7, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtpd_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtpd_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtpd_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtpd_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 9223372036854775807, 3, 9223372036854775807, 5, 9223372036854775807, 7, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtpd_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtpd_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtpd_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtpd_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtpd_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtpd_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtpd_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtpd_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -1, 3, -1, 5, -1, 7, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtpd_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtpd_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtpd_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtpd_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 9223372036854775807, 3, -1, 5, 9223372036854775807, 7, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtpd_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtpd_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvtpd_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_cvtpd_epi64(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtpd_epi64(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtpd_epi64(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtpd_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvtpd_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvt_roundps_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_cvt_roundps_epi64::<8>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm512_cvt_roundps_epi64::<8>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvt_roundps_epi64::<8>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvt_roundps_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_cvt_roundps_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvt_roundps_epi64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 17179869187, 19, 34359738375, 21, 51539607563, 23, 68719476751]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundps_epi64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundps_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundps_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvt_roundps_epi64::<8>(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -1, 3, -3, 5, -5, 7, -7]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundps_epi64::<8>(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundps_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvt_roundps_epi64::<8>(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundps_epi64::<8>(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundps_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvt_roundps_epi64::<8>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -9223372036854775808, 3, -9223372036854775808, 5, -9223372036854775808, 7, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundps_epi64::<8>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundps_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvt_roundps_epi64::<8>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 9223372036854775807, 3, 9223372036854775807, 5, 9223372036854775807, 7, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundps_epi64::<8>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundps_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvt_roundps_epi64::<8>(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundps_epi64::<8>(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundps_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvt_roundps_epi64::<8>(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -1, 3, -1, 5, -1, 7, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundps_epi64::<8>(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundps_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvt_roundps_epi64::<8>(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 9223372036854775807, 3, -1, 5, 9223372036854775807, 7, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundps_epi64::<8>(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundps_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundps_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvt_roundps_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_cvt_roundps_epi64::<8>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvt_roundps_epi64::<8>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvt_roundps_epi64::<8>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvt_roundps_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvt_roundps_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_cvtps_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cvtps_epi64(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: _mm_cvtps_epi64(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtps_epi64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_cvtps_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_cvtps_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtps_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtps_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[5, 17179869187]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtps_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtps_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtps_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtps_epi64(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, -1]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epi64(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtps_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtps_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtps_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtps_epi64(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 200]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epi64(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtps_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtps_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtps_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtps_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtps_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtps_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtps_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtps_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtps_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtps_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtps_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtps_epi64(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epi64(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtps_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtps_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtps_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtps_epi64(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, -1]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epi64(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtps_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtps_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtps_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtps_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtps_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtps_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_maskz_cvtps_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_cvtps_epi64(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtps_epi64(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtps_epi64(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_maskz_cvtps_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_maskz_cvtps_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_cvtps_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cvtps_epi64(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: _mm256_cvtps_epi64(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtps_epi64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_cvtps_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_cvtps_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtps_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtps_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_array_equality(&result, &[9, 17179869187, 11, 34359738375]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtps_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtps_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtps_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtps_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, -1, 3, -3]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtps_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtps_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtps_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtps_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 200, 3, 400]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtps_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtps_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtps_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtps_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, -9223372036854775808, 3, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtps_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtps_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtps_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtps_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 9223372036854775807, 3, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtps_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtps_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtps_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtps_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtps_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtps_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtps_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtps_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, -1, 3, -1]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtps_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtps_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtps_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtps_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 9223372036854775807, 3, -1]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtps_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtps_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_cvtps_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_cvtps_epi64(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtps_epi64(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtps_epi64(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_maskz_cvtps_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_maskz_cvtps_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvtps_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_cvtps_epi64(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm512_cvtps_epi64(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtps_epi64(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvtps_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_cvtps_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtps_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtps_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 17179869187, 19, 34359738375, 21, 51539607563, 23, 68719476751]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epi64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtps_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtps_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtps_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtps_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -1, 3, -3, 5, -5, 7, -7]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epi64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtps_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtps_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtps_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtps_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epi64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtps_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtps_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtps_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtps_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -9223372036854775808, 3, -9223372036854775808, 5, -9223372036854775808, 7, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epi64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtps_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtps_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtps_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtps_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 9223372036854775807, 3, 9223372036854775807, 5, 9223372036854775807, 7, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epi64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtps_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtps_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtps_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtps_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epi64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtps_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtps_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtps_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtps_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -1, 3, -1, 5, -1, 7, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epi64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtps_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtps_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtps_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtps_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 9223372036854775807, 3, -1, 5, 9223372036854775807, 7, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epi64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtps_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtps_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvtps_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_cvtps_epi64(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtps_epi64(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtps_epi64(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtps_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvtps_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvt_roundpd_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_cvt_roundpd_epu64::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm512_cvt_roundpd_epu64::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvt_roundpd_epu64::<8>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvt_roundpd_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_cvt_roundpd_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvt_roundpd_epu64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 17179869187, 19, 34359738375, 21, 51539607563, 23, 68719476751]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundpd_epu64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundpd_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvt_roundpd_epu64::<8>(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551613, 5, 18446744073709551611, 7, 18446744073709551609]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundpd_epu64::<8>(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundpd_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvt_roundpd_epu64::<8>(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundpd_epu64::<8>(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundpd_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvt_roundpd_epu64::<8>(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundpd_epu64::<8>(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundpd_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvt_roundpd_epu64::<8>(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615, 5, 18446744073709551615, 7, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundpd_epu64::<8>(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundpd_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvt_roundpd_epu64::<8>(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundpd_epu64::<8>(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundpd_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvt_roundpd_epu64::<8>(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615, 5, 18446744073709551615, 7, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundpd_epu64::<8>(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundpd_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvt_roundpd_epu64::<8>(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615, 5, 18446744073709551615, 7, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundpd_epu64::<8>(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundpd_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundpd_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvt_roundpd_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_maskz_cvt_roundpd_epu64::<8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvt_roundpd_epu64::<8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvt_roundpd_epu64::<8>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvt_roundpd_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvt_roundpd_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_cvtpd_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_cvtpd_epu64(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: _mm_cvtpd_epu64(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtpd_epu64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_cvtpd_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_cvtpd_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtpd_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_cvtpd_epu64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128d_from([5.0, 6.0])));
        check_array_equality(&result, &[5, 17179869187]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epu64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtpd_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtpd_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtpd_epu64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_cvtpd_epu64(create__m128i_from_i64_array([((0u64) as i64), ((18446744073709551615u64) as i64)]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epu64(create__m128i_from_i64_array([((0u64) as i64), ((18446744073709551615u64) as i64)]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtpd_epu64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtpd_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtpd_epu64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_cvtpd_epu64(create__m128i_from_i64_array([((100u64) as i64), ((200u64) as i64)]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 200]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epu64(create__m128i_from_i64_array([((100u64) as i64), ((200u64) as i64)]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtpd_epu64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtpd_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtpd_epu64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_cvtpd_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtpd_epu64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtpd_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtpd_epu64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_cvtpd_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtpd_epu64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtpd_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtpd_epu64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_cvtpd_epu64(create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epu64(create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtpd_epu64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtpd_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtpd_epu64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_cvtpd_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtpd_epu64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtpd_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtpd_epu64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_cvtpd_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm_mask_cvtpd_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtpd_epu64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtpd_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_maskz_cvtpd_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_maskz_cvtpd_epu64(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtpd_epu64(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtpd_epu64(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_maskz_cvtpd_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_maskz_cvtpd_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_cvtpd_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_cvtpd_epu64(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: _mm256_cvtpd_epu64(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtpd_epu64(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_cvtpd_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_cvtpd_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtpd_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_cvtpd_epu64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256d_from([9.0, 10.0, 11.0, 12.0])));
        check_array_equality(&result, &[9, 17179869187, 11, 34359738375]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epu64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256d_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtpd_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtpd_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtpd_epu64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_cvtpd_epu64(create__m256i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64)]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551613]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epu64(create__m256i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64)]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtpd_epu64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtpd_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtpd_epu64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_cvtpd_epu64(create__m256i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64)]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 200, 3, 400]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epu64(create__m256i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64)]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtpd_epu64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtpd_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtpd_epu64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_cvtpd_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtpd_epu64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtpd_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtpd_epu64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_cvtpd_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtpd_epu64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtpd_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtpd_epu64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_cvtpd_epu64(create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epu64(create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtpd_epu64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtpd_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtpd_epu64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_cvtpd_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtpd_epu64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtpd_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtpd_epu64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_cvtpd_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm256_mask_cvtpd_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtpd_epu64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtpd_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_cvtpd_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_maskz_cvtpd_epu64(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtpd_epu64(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtpd_epu64(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_maskz_cvtpd_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_maskz_cvtpd_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvtpd_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_cvtpd_epu64(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm512_cvtpd_epu64(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtpd_epu64(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvtpd_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_cvtpd_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtpd_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtpd_epu64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 17179869187, 19, 34359738375, 21, 51539607563, 23, 68719476751]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epu64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtpd_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtpd_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtpd_epu64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtpd_epu64(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551613, 5, 18446744073709551611, 7, 18446744073709551609]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epu64(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtpd_epu64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtpd_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtpd_epu64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtpd_epu64(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epu64(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtpd_epu64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtpd_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtpd_epu64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtpd_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtpd_epu64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtpd_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtpd_epu64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtpd_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615, 5, 18446744073709551615, 7, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtpd_epu64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtpd_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtpd_epu64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtpd_epu64(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epu64(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtpd_epu64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtpd_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtpd_epu64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtpd_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615, 5, 18446744073709551615, 7, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtpd_epu64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtpd_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtpd_epu64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtpd_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615, 5, 18446744073709551615, 7, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm512_mask_cvtpd_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtpd_epu64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtpd_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvtpd_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_maskz_cvtpd_epu64(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtpd_epu64(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtpd_epu64(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtpd_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvtpd_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvt_roundps_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_cvt_roundps_epu64::<8>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm512_cvt_roundps_epu64::<8>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvt_roundps_epu64::<8>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvt_roundps_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_cvt_roundps_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvt_roundps_epu64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 17179869187, 19, 34359738375, 21, 51539607563, 23, 68719476751]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundps_epu64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundps_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundps_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvt_roundps_epu64::<8>(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551613, 5, 18446744073709551611, 7, 18446744073709551609]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundps_epu64::<8>(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundps_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvt_roundps_epu64::<8>(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundps_epu64::<8>(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundps_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvt_roundps_epu64::<8>(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundps_epu64::<8>(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundps_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvt_roundps_epu64::<8>(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615, 5, 18446744073709551615, 7, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundps_epu64::<8>(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundps_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvt_roundps_epu64::<8>(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundps_epu64::<8>(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundps_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvt_roundps_epu64::<8>(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615, 5, 18446744073709551615, 7, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundps_epu64::<8>(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundps_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvt_roundps_epu64::<8>(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615, 5, 18446744073709551615, 7, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm512_mask_cvt_roundps_epu64::<8>(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundps_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvt_roundps_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvt_roundps_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_maskz_cvt_roundps_epu64::<8>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvt_roundps_epu64::<8>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvt_roundps_epu64::<8>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvt_roundps_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvt_roundps_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_cvtps_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_cvtps_epu64(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: _mm_cvtps_epu64(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtps_epu64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_cvtps_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_cvtps_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtps_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_cvtps_epu64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[5, 17179869187]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epu64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtps_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtps_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtps_epu64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_cvtps_epu64(create__m128i_from_i64_array([((0u64) as i64), ((18446744073709551615u64) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epu64(create__m128i_from_i64_array([((0u64) as i64), ((18446744073709551615u64) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtps_epu64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtps_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtps_epu64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_cvtps_epu64(create__m128i_from_i64_array([((100u64) as i64), ((200u64) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 200]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epu64(create__m128i_from_i64_array([((100u64) as i64), ((200u64) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtps_epu64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtps_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtps_epu64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_cvtps_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtps_epu64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtps_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtps_epu64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_cvtps_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtps_epu64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtps_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtps_epu64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_cvtps_epu64(create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epu64(create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtps_epu64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtps_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtps_epu64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_cvtps_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtps_epu64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtps_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_cvtps_epu64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_cvtps_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm_mask_cvtps_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtps_epu64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_mask_cvtps_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_maskz_cvtps_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_maskz_cvtps_epu64(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtps_epu64(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtps_epu64(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_maskz_cvtps_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_maskz_cvtps_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_cvtps_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_cvtps_epu64(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: _mm256_cvtps_epu64(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtps_epu64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_cvtps_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_cvtps_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtps_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_cvtps_epu64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_array_equality(&result, &[9, 17179869187, 11, 34359738375]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epu64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epu64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtps_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtps_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtps_epu64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_cvtps_epu64(create__m256i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551613]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epu64(create__m256i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epu64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtps_epu64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtps_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtps_epu64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_cvtps_epu64(create__m256i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 200, 3, 400]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epu64(create__m256i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epu64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtps_epu64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtps_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtps_epu64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_cvtps_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epu64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtps_epu64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtps_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtps_epu64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_cvtps_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epu64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtps_epu64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtps_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtps_epu64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_cvtps_epu64(create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epu64(create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epu64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtps_epu64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtps_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtps_epu64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_cvtps_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epu64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtps_epu64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtps_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_cvtps_epu64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_cvtps_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm256_mask_cvtps_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epu64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtps_epu64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_mask_cvtps_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_cvtps_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_maskz_cvtps_epu64(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_cvtps_epu64(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtps_epu64(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_maskz_cvtps_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm256_maskz_cvtps_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvtps_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_cvtps_epu64(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm512_cvtps_epu64(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtps_epu64(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvtps_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_cvtps_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtps_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtps_epu64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 17179869187, 19, 34359738375, 21, 51539607563, 23, 68719476751]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epu64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epu64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtps_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtps_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtps_epu64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtps_epu64(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551613, 5, 18446744073709551611, 7, 18446744073709551609]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epu64(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epu64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtps_epu64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtps_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtps_epu64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtps_epu64(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epu64(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epu64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtps_epu64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtps_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtps_epu64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtps_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epu64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtps_epu64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtps_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtps_epu64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtps_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615, 5, 18446744073709551615, 7, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epu64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtps_epu64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtps_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtps_epu64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtps_epu64(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epu64(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epu64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtps_epu64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtps_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtps_epu64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtps_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615, 5, 18446744073709551615, 7, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epu64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtps_epu64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtps_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtps_epu64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtps_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615, 5, 18446744073709551615, 7, 18446744073709551615]).map_err(|e| format!("{e} | call: _mm512_mask_cvtps_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epu64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtps_epu64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtps_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvtps_epu64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_maskz_cvtps_epu64(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtps_epu64(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtps_epu64(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtps_epu64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvtps_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvtt_roundpd_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_cvtt_roundpd_epi64::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm512_cvtt_roundpd_epi64::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtt_roundpd_epi64::<8>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvtt_roundpd_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_cvtt_roundpd_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 17179869187, 19, 34359738375, 21, 51539607563, 23, 68719476751]).map_err(|e| format!("{e} | call: _mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -1, 3, -3, 5, -5, 7, -7]).map_err(|e| format!("{e} | call: _mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_normal2() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800]).map_err(|e| format!("{e} | call: _mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_normal3() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -9223372036854775808, 3, -9223372036854775808, 5, -9223372036854775808, 7, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 9223372036854775807, 3, 9223372036854775807, 5, 9223372036854775807, 7, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -1, 3, -1, 5, -1, 7, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 9223372036854775807, 3, -1, 5, 9223372036854775807, 7, -1]).map_err(|e| format!("{e} | call: _mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvtt_roundpd_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_cvtt_roundpd_epi64::<8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_cvtt_roundpd_epi64::<8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtt_roundpd_epi64::<8>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtt_roundpd_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvtt_roundpd_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_cvttpd_epi64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cvttpd_epi64(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2]).map_err(|e| format!("{e} | call: _mm_cvttpd_epi64(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttpd_epi64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_cvttpd_epi64() -> Result<(), String> {
    unsafe { test_x86_avx512dq_mm_cvttpd_epi64_impl() }
}
