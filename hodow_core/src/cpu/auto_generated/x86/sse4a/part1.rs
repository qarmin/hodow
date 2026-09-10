#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_extract_si64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extract_si64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result[..2], &[1, 0, 0, 0][..2]).map_err(|e| format!("{e} | call: _mm_extract_si64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_extract_si64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_extract_si64() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_extract_si64_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_extracti_si64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result[..2], &[1, 2, 3, 4][..2]).map_err(|e| format!("{e} | call: _mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_extracti_si64::<0, 0>(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_extracti_si64() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_extracti_si64_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_extracti_si64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([0, -1, 2, -3])));
        check_array_equality(&result[..2], &[0, -1, 2, -3][..2]).map_err(|e| format!("{e} | call: _mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([0, -1, 2, -3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_extracti_si64::<0, 0>(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_extracti_si64_normal2() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_extracti_si64_normal2_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_extracti_si64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([100, 200, 300, 400])));
        check_array_equality(&result[..2], &[100, 200, 300, 400][..2]).map_err(|e| format!("{e} | call: _mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([100, 200, 300, 400]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_extracti_si64::<0, 0>(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_extracti_si64_normal3() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_extracti_si64_normal3_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_extracti_si64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result[..2], &[-2147483648, -2147483648, -2147483648, -2147483648][..2]).map_err(|e| format!("{e} | call: _mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_extracti_si64::<0, 0>(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_extracti_si64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_extracti_si64_boundary_min_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_extracti_si64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result[..2], &[2147483647, 2147483647, 2147483647, 2147483647][..2]).map_err(|e| format!("{e} | call: _mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_extracti_si64::<0, 0>(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_extracti_si64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_extracti_si64_boundary_max_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_extracti_si64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result[..2], &[0; 4][..2]).map_err(|e| format!("{e} | call: _mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_extracti_si64::<0, 0>(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_extracti_si64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_extracti_si64_boundary_zero_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_extracti_si64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result[..2], &[-1, -1, -1, -1][..2]).map_err(|e| format!("{e} | call: _mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_extracti_si64::<0, 0>(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_extracti_si64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_extracti_si64_boundary_allones_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_extracti_si64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result[..2], &[-2147483648, 2147483647, 0, -1][..2]).map_err(|e| format!("{e} | call: _mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_extracti_si64::<0, 0>(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_extracti_si64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_extracti_si64_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_insert_si64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_insert_si64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result[..2], &[5, 2, 0, 0][..2]).map_err(|e| format!("{e} | call: _mm_insert_si64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_insert_si64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_insert_si64() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_insert_si64_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_inserti_si64_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result[..2], &[5, 6, 7, 8][..2]).map_err(|e| format!("{e} | call: _mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_inserti_si64::<0, 0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_inserti_si64() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_inserti_si64_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_inserti_si64_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result[..2], &[10, 9, 12, 7][..2]).map_err(|e| format!("{e} | call: _mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_inserti_si64::<0, 0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_inserti_si64_normal2() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_inserti_si64_normal2_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_inserti_si64_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result[..2], &[110, 210, 310, 410][..2]).map_err(|e| format!("{e} | call: _mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_inserti_si64::<0, 0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_inserti_si64_normal3() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_inserti_si64_normal3_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_inserti_si64_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result[..2], &[-2147483648, -2147483648, -2147483648, -2147483648][..2]).map_err(|e| format!("{e} | call: _mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_inserti_si64::<0, 0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_inserti_si64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_inserti_si64_boundary_min_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_inserti_si64_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result[..2], &[2147483647, 2147483647, 2147483647, 2147483647][..2]).map_err(|e| format!("{e} | call: _mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_inserti_si64::<0, 0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_inserti_si64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_inserti_si64_boundary_max_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_inserti_si64_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result[..2], &[0; 4][..2]).map_err(|e| format!("{e} | call: _mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_inserti_si64::<0, 0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_inserti_si64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_inserti_si64_boundary_zero_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_inserti_si64_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result[..2], &[-1, -1, -1, -1][..2]).map_err(|e| format!("{e} | call: _mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_inserti_si64::<0, 0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_inserti_si64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_inserti_si64_boundary_allones_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_inserti_si64_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result[..2], &[-2147483648, 2147483647, 0, -1][..2]).map_err(|e| format!("{e} | call: _mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_inserti_si64::<0, 0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_inserti_si64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_inserti_si64_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_inserti_si64_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result[..2], &[2147483647, 2147483647, 2147483647, 2147483647][..2]).map_err(|e| format!("{e} | call: _mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_inserti_si64::<0, 0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_inserti_si64_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_inserti_si64_asym_min_max_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_inserti_si64_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result[..2], &[-2147483648, -2147483648, -2147483648, -2147483648][..2]).map_err(|e| format!("{e} | call: _mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_inserti_si64::<0, 0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_inserti_si64_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_inserti_si64_asym_max_min_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_sd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([2.0, 3.0]);
        _mm_stream_sd(ptr_p.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_stream_sd() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_stream_sd_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_sd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([0.0f64, -1.0f64]);
        _mm_stream_sd(ptr_p.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_stream_sd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_stream_sd_normal2_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_sd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([100.0f64, 200.0f64]);
        _mm_stream_sd(ptr_p.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_stream_sd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_stream_sd_normal3_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_sd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::MIN, f64::MIN]);
        _mm_stream_sd(ptr_p.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_stream_sd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_stream_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_sd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::MAX, f64::MAX]);
        _mm_stream_sd(ptr_p.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_stream_sd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_stream_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_sd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([0.0, 0.0]);
        _mm_stream_sd(ptr_p.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_stream_sd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_stream_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_sd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::NAN, f64::NAN]);
        _mm_stream_sd(ptr_p.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_stream_sd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_stream_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_sd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]);
        _mm_stream_sd(ptr_p.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_stream_sd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_stream_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_ss_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([2.0, 3.0, 4.0, 5.0]);
        _mm_stream_ss(ptr_p.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_stream_ss() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_stream_ss_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_ss_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]);
        _mm_stream_ss(ptr_p.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_stream_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_stream_ss_normal2_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_ss_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]);
        _mm_stream_ss(ptr_p.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_stream_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_stream_ss_normal3_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_ss_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        _mm_stream_ss(ptr_p.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_stream_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_stream_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_ss_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        _mm_stream_ss(ptr_p.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_stream_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_stream_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_ss_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([0.0, 0.0, 0.0, 0.0]);
        _mm_stream_ss(ptr_p.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_stream_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_stream_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_ss_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        _mm_stream_ss(ptr_p.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_stream_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_stream_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_ss_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        _mm_stream_ss(ptr_p.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse4a_mm_stream_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse4a_mm_stream_ss_boundary_mixed_impl() }
}
