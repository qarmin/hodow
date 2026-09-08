#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg1_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg1_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[6, 10, 2, 6]).map_err(|e| format!("{e} | call: _mm_sha1msg1_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg1_epu32() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg1_epu32_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg1_epu32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg1_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[12, 4294967288, 2, 2]).map_err(|e| format!("{e} | call: _mm_sha1msg1_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg1_epu32_normal2() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg1_epu32_normal2_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg1_epu32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg1_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[338, 338, 328, 344]).map_err(|e| format!("{e} | call: _mm_sha1msg1_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg1_epu32_normal3() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg1_epu32_normal3_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg1_epu32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg1_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sha1msg1_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg1_epu32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg1_epu32_boundary_min_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg1_epu32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg1_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sha1msg1_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg1_epu32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg1_epu32_boundary_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg1_epu32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg1_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sha1msg1_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg1_epu32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg1_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg1_epu32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg1_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sha1msg1_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg1_epu32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg1_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg1_epu32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg1_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sha1msg1_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg1_epu32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg1_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg1_epu32_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg1_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 0, 0]).map_err(|e| format!("{e} | call: _mm_sha1msg1_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg1_epu32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg1_epu32_asym_min_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg1_epu32_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg1_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[4294967295, 4294967295, 0, 0]).map_err(|e| format!("{e} | call: _mm_sha1msg1_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg1_epu32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg1_epu32_asym_max_min_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[14, 14, 10, 6]).map_err(|e| format!("{e} | call: _mm_sha1msg2_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[4294967239, 4294967275, 22, 4294967267]).map_err(|e| format!("{e} | call: _mm_sha1msg2_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32_normal2() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_normal2_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[592, 332, 1020, 332]).map_err(|e| format!("{e} | call: _mm_sha1msg2_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32_normal3() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_normal3_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_boundary_min_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_boundary_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sha1msg2_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| format!("{e} | call: _mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| format!("{e} | call: _mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_asym_min_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 4294967295, 4294967295, 4294967295]).map_err(|e| format!("{e} | call: _mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_asym_max_min_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1nexte_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1nexte_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 6, 7, 9]).map_err(|e| format!("{e} | call: _mm_sha1nexte_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1nexte_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1nexte_epu32() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1nexte_epu32_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1nexte_epu32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1nexte_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[10, 9, 12, 2147483654]).map_err(|e| format!("{e} | call: _mm_sha1nexte_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1nexte_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1nexte_epu32_normal2() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1nexte_epu32_normal2_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1nexte_epu32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1nexte_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[110, 210, 310, 510]).map_err(|e| format!("{e} | call: _mm_sha1nexte_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1nexte_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1nexte_epu32_normal3() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1nexte_epu32_normal3_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1nexte_epu32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1nexte_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sha1nexte_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1nexte_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1nexte_epu32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1nexte_epu32_boundary_min_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1nexte_epu32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1nexte_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967294]).map_err(|e| format!("{e} | call: _mm_sha1nexte_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1nexte_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1nexte_epu32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1nexte_epu32_boundary_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1nexte_epu32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1nexte_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sha1nexte_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1nexte_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1nexte_epu32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1nexte_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1nexte_epu32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1nexte_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967294]).map_err(|e| format!("{e} | call: _mm_sha1nexte_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1nexte_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1nexte_epu32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1nexte_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1nexte_epu32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1nexte_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0, 4294967295, 0, 4294967294]).map_err(|e| format!("{e} | call: _mm_sha1nexte_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1nexte_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1nexte_epu32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1nexte_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1nexte_epu32_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1nexte_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| format!("{e} | call: _mm_sha1nexte_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1nexte_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1nexte_epu32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1nexte_epu32_asym_min_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1nexte_epu32_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1nexte_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 4294967295]).map_err(|e| format!("{e} | call: _mm_sha1nexte_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1nexte_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1nexte_epu32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1nexte_epu32_asym_max_min_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[3600850568, 2863951747, 884620151, 877299341]).map_err(|e| format!("{e} | call: _mm_sha1rnds4_epu32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[1453366872, 2327079284, 2402921799, 426180881]).map_err(|e| format!("{e} | call: _mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_normal2() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_normal2_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[3600853854, 2864057017, 3045578856, 2382213550]).map_err(|e| format!("{e} | call: _mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_normal3() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_normal3_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[1453366886, 716466993, 3031962158, 4093987763]).map_err(|e| format!("{e} | call: _mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_boundary_min_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[2527108709, 1790208792, 3031958987, 3375502092]).map_err(|e| format!("{e} | call: _mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_boundary_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[1453366886, 716466993, 3031962158, 4093987763]).map_err(|e| format!("{e} | call: _mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[2527108709, 1790208792, 3031958987, 3375502092]).map_err(|e| format!("{e} | call: _mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[3600850533, 716466977, 255493059, 427938169]).map_err(|e| format!("{e} | call: _mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_asym_min_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[379625062, 3937692456, 3031961101, 4093953904]).map_err(|e| format!("{e} | call: _mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_asym_min_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_asym_max_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[3600850533, 2863950624, 3031960044, 3375535787]).map_err(|e| format!("{e} | call: _mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_asym_max_min_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_imm_0_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[3600850568, 2863951747, 884620151, 877299341]).map_err(|e| format!("{e} | call: _mm_sha1rnds4_epu32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_imm_0() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_imm_0_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_imm_1_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1538685706, 42327095, 1621226322, 2495177161]).map_err(|e| format!("{e} | call: _mm_sha1rnds4_epu32::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1rnds4_epu32::<1>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_imm_1() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_imm_1_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg1_epu32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg1_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[67141633, 100712450, 134283267, 167854084]).map_err(|e| format!("{e} | call: _mm_sha256msg1_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg1_epu32() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg1_epu32_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg1_epu32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg1_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[536870911, 67141631, 469729281, 335708158]).map_err(|e| format!("{e} | call: _mm_sha256msg1_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg1_epu32_normal2() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg1_epu32_normal2_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg1_epu32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg1_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[2419196028, 1481310447, 543424861, 3692790173]).map_err(|e| format!("{e} | call: _mm_sha256msg1_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg1_epu32_normal3() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg1_epu32_normal3_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg1_epu32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg1_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sha256msg1_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg1_epu32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg1_epu32_boundary_min_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg1_epu32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg1_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[536870910, 536870910, 536870910, 536870910]).map_err(|e| format!("{e} | call: _mm_sha256msg1_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg1_epu32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg1_epu32_boundary_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg1_epu32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg1_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sha256msg1_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg1_epu32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg1_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg1_epu32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg1_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[536870910, 536870910, 536870910, 536870910]).map_err(|e| format!("{e} | call: _mm_sha256msg1_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg1_epu32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg1_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg1_epu32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg1_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[536870911, 4294967295, 536870911, 4294967295]).map_err(|e| format!("{e} | call: _mm_sha256msg1_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg1_epu32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg1_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg1_epu32_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg1_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[0, 0, 0, 536870911]).map_err(|e| format!("{e} | call: _mm_sha256msg1_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg1_epu32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg1_epu32_asym_min_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg1_epu32_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg1_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[536870910, 536870910, 536870910, 4294967295]).map_err(|e| format!("{e} | call: _mm_sha256msg1_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg1_epu32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg1_epu32_asym_max_min_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[221185, 327682, 3691028700, 536953158]).map_err(|e| format!("{e} | call: _mm_sha256msg2_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[491520, 221183, 805306853, 3288359123]).map_err(|e| format!("{e} | call: _mm_sha256msg2_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32_normal2() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_normal2_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[12435556, 16662728, 1480503397, 3900522880]).map_err(|e| format!("{e} | call: _mm_sha256msg2_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32_normal3() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_normal3_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_boundary_min_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4194302, 4194302, 53222, 53222]).map_err(|e| format!("{e} | call: _mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_boundary_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sha256msg2_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4194302, 4194302, 53222, 53222]).map_err(|e| format!("{e} | call: _mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0, 4194302, 0, 53222]).map_err(|e| format!("{e} | call: _mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4194303, 4194303, 28647, 28647]).map_err(|e| format!("{e} | call: _mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_asym_min_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[4294967295, 4294967295, 4194302, 4194302]).map_err(|e| format!("{e} | call: _mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_asym_max_min_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[415236881, 1178701972, 419439380, 1689133364]).map_err(|e| format!("{e} | call: _mm_sha256rnds2_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7]), create__m128i_from_u32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[622855316, 1376939545, 3847757984, 2934312860]).map_err(|e| format!("{e} | call: _mm_sha256rnds2_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7]), create__m128i_from_u32_array([20, 19, 22, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32_normal2() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_normal2_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410]), create__m128i_from_u32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[1379953493, 534177463, 3742815265, 2909974811]).map_err(|e| format!("{e} | call: _mm_sha256rnds2_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410]), create__m128i_from_u32_array([120, 220, 320, 420]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32_normal3() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_normal3_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_boundary_min_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967291, 4018142715, 4294967290, 2941774329]).map_err(|e| format!("{e} | call: _mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_boundary_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sha256rnds2_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967291, 4018142715, 4294967290, 2941774329]).map_err(|e| format!("{e} | call: _mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967291, 4294967293, 2146433016]).map_err(|e| format!("{e} | call: _mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[4294967295, 0, 4294967293, 2146433022]).map_err(|e| format!("{e} | call: _mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_asym_min_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[4294967294, 4225761151, 4294967295, 4225761151]).map_err(|e| format!("{e} | call: _mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_asym_max_min_impl() }
}
