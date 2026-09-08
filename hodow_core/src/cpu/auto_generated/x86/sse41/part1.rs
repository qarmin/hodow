#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_insert_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_insert_ps() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_insert_ps_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[10.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_insert_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_insert_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_insert_ps_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[110.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_insert_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_insert_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_insert_ps_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_insert_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_insert_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_insert_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_insert_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_insert_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_insert_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_insert_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_insert_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_insert_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_insert_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_insert_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_insert_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_insert_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_insert_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_insert_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_insert_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_insert_ps_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_insert_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_insert_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_insert_ps_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_insert_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_insert_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_insert_ps_imm_0() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_insert_ps_imm_0_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_insert_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_insert_ps::<1>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_insert_ps_imm_1() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_insert_ps_imm_1_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_packus_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packus_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[131073, 262147, 393221, 524295]).map_err(|e| format!("{e} | call: _mm_packus_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_packus_epi32() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_packus_epi32_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_packus_epi32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packus_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0, 2, 589834, 458764]).map_err(|e| format!("{e} | call: _mm_packus_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_packus_epi32_normal2() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_packus_epi32_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_packus_epi32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packus_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[13107300, 26214700, 13762670, 26870070]).map_err(|e| format!("{e} | call: _mm_packus_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_packus_epi32_normal3() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_packus_epi32_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_packus_epi32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packus_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_packus_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_packus_epi32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_packus_epi32_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_packus_epi32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packus_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm_packus_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_packus_epi32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_packus_epi32_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_packus_epi32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packus_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_packus_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_packus_epi32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_packus_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_packus_epi32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packus_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_packus_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_packus_epi32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_packus_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_packus_epi32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packus_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-65536, 0, -65536, 0]).map_err(|e| format!("{e} | call: _mm_packus_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_packus_epi32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_packus_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_packus_epi32_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packus_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 0, -1, -1]).map_err(|e| format!("{e} | call: _mm_packus_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_packus_epi32_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_packus_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_packus_epi32_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packus_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, -1, 0, 0]).map_err(|e| format!("{e} | call: _mm_packus_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_packus_epi32_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_packus_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_pd_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_dp_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_dp_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_pd() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_pd_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_pd_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_dp_pd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_dp_pd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_pd_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_pd_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_dp_pd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_dp_pd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_pd_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_pd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_dp_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_dp_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_pd_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_pd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_dp_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_dp_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_pd_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_pd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_dp_pd::<0>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_dp_pd::<0>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_pd_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_pd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_dp_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_dp_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_pd_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_pd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_dp_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_dp_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_pd_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_dp_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_dp_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_pd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_pd_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_pd_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_dp_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_dp_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_pd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_pd_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_pd_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_dp_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_dp_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_pd_imm_0() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_pd_imm_0_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_pd_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_dp_pd::<1>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_dp_pd::<1>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_pd::<1>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_pd_imm_1() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_pd_imm_1_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dp_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_dp_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_ps() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_ps_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dp_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_dp_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_ps_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dp_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_dp_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_ps_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dp_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_dp_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dp_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_dp_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dp_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_dp_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dp_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_dp_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dp_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_dp_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_ps_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dp_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_dp_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_ps_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_ps_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dp_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_dp_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_ps_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_ps_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dp_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_dp_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_ps_imm_0() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_ps_imm_0_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_dp_ps_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dp_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_dp_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_ps::<1>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_ps_imm_1() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_dp_ps_imm_1_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_sd_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_floor_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| format!("{e} | call: _mm_floor_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_sd() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_sd_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_sd_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_floor_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[10.0, -1.0]).map_err(|e| format!("{e} | call: _mm_floor_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_sd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_sd_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_sd_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_floor_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[110.0, 200.0]).map_err(|e| format!("{e} | call: _mm_floor_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_sd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_sd_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_sd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_floor_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_floor_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_sd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_sd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_floor_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_floor_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_sd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_sd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_floor_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_floor_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_sd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_sd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_floor_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_floor_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_sd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_sd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_floor_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_floor_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_sd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_sd_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_floor_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_floor_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_sd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_sd_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_sd_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_floor_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_floor_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_sd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_sd_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_floor_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_floor_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_ss() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_ss_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_floor_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[10.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_floor_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_ss_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_floor_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[110.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_floor_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_ss_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_floor_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_floor_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_floor_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_floor_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_floor_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_floor_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_floor_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_floor_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_floor_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_floor_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_floor_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_floor_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_floor_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_floor_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_floor_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_floor_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_sd_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_ceil_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| format!("{e} | call: _mm_ceil_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_sd() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_sd_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_sd_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_ceil_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[10.0, -1.0]).map_err(|e| format!("{e} | call: _mm_ceil_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_sd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_sd_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_sd_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_ceil_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[110.0, 200.0]).map_err(|e| format!("{e} | call: _mm_ceil_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_sd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_sd_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_sd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_ceil_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_ceil_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_sd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_sd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_ceil_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_ceil_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_sd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_sd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_ceil_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_ceil_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_sd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_sd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_ceil_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_ceil_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_sd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_sd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_ceil_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_ceil_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_sd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_sd_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_ceil_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_ceil_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_sd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_sd_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_sd_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_ceil_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_ceil_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_sd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_sd_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_ceil_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_ceil_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_ss() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_ss_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_ceil_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[10.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_ceil_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_ss_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_ceil_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[110.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_ceil_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_ss_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_ceil_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_ceil_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_ceil_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_ceil_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_ceil_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_ceil_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_ceil_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_ceil_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_ceil_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_ceil_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_ceil_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_ceil_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_ceil_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_ceil_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_ceil_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_ceil_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_pd_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_pd::<8>(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: _mm_round_pd::<8>(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_pd::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_pd() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_pd_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_pd_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_pd::<8>(create__m128d_from([0.0f64, -1.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| format!("{e} | call: _mm_round_pd::<8>(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_pd::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_pd_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_pd_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_pd::<8>(create__m128d_from([100.0f64, 200.0f64])));
        check_float_array_equality(&result, &[100.0, 200.0]).map_err(|e| format!("{e} | call: _mm_round_pd::<8>(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_pd::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_pd_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_pd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_pd::<8>(create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_round_pd::<8>(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_pd::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_pd_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_pd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_pd::<8>(create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_round_pd::<8>(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_pd::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_pd_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_pd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_pd::<8>(create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_round_pd::<8>(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_pd::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_pd_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_pd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_pd::<8>(create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_round_pd::<8>(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_pd::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_pd_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_pd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_pd::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_round_pd::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_pd::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ps::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_round_ps::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ps::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ps() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_ps_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ps::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_round_ps::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ps::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_ps_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ps::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_round_ps::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ps::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_ps_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ps::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_round_ps::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ps::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ps::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_round_ps::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ps::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ps::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_round_ps::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ps::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ps::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_round_ps::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ps::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ps::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_round_ps::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ps::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_sd_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_sd::<8>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| format!("{e} | call: _mm_round_sd::<8>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_sd::<8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_sd() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_sd_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_sd_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_sd::<8>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[10.0, -1.0]).map_err(|e| format!("{e} | call: _mm_round_sd::<8>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_sd::<8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_sd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_sd_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_sd_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_sd::<8>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[110.0, 200.0]).map_err(|e| format!("{e} | call: _mm_round_sd::<8>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_sd::<8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_sd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_sd_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_sd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_sd::<8>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_round_sd::<8>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_sd::<8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_sd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_sd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_sd::<8>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_round_sd::<8>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_sd::<8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_sd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_sd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_sd::<8>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_round_sd::<8>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_sd::<8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_sd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_sd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_sd::<8>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_round_sd::<8>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_sd::<8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_sd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_sd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_sd::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_round_sd::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_sd::<8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_sd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_sd_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_sd::<8>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_round_sd::<8>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_sd::<8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_sd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_sd_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_sd_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_sd::<8>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_round_sd::<8>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_sd::<8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_sd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_sd_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_round_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ss::<8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ss() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_ss_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ss::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[10.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_round_ss::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ss::<8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_ss_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ss::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[110.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_round_ss::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ss::<8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_ss_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ss::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_round_ss::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ss::<8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ss::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_round_ss::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ss::<8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ss::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_round_ss::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ss::<8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ss::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_round_ss::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ss::<8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ss::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_round_ss::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ss::<8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ss::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_round_ss::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ss::<8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_round_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ss::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_round_ss::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ss::<8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_round_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_minpos_epu16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_minpos_epu16(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 1, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_minpos_epu16(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_minpos_epu16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_minpos_epu16() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_minpos_epu16_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_minpos_epu16_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_minpos_epu16(create__m128i_from_u16_array([0, 65535, 2, 65533, 4, 65531, 6, 65529])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_minpos_epu16(create__m128i_from_u16_array([0, 65535, 2, 65533, 4, 65531, 6, 65529]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_minpos_epu16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_minpos_epu16_normal2() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_minpos_epu16_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_minpos_epu16_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_minpos_epu16(create__m128i_from_u16_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[100, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_minpos_epu16(create__m128i_from_u16_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_minpos_epu16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_minpos_epu16_normal3() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_minpos_epu16_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_minpos_epu16_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_minpos_epu16(create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_minpos_epu16(create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_minpos_epu16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_minpos_epu16_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_minpos_epu16_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_minpos_epu16_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_minpos_epu16(create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_minpos_epu16(create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_minpos_epu16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_minpos_epu16_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_minpos_epu16_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_minpos_epu16_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_minpos_epu16(create__m128i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_minpos_epu16(create__m128i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_minpos_epu16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_minpos_epu16_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_minpos_epu16_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_minpos_epu16_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_minpos_epu16(create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_minpos_epu16(create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_minpos_epu16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_minpos_epu16_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_minpos_epu16_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_minpos_epu16_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_minpos_epu16(create__m128i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_minpos_epu16(create__m128i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_minpos_epu16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_minpos_epu16_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_minpos_epu16_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_mpsadbw_epu8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mpsadbw_epu8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 0, 7, 0, 7, 0, 7, 0, 3, 0, 8, 0, 8, 0, 8, 0]).map_err(|e| format!("{e} | call: _mm_mpsadbw_epu8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mpsadbw_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mpsadbw_epu8() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_mpsadbw_epu8_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_mpsadbw_epu8_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mpsadbw_epu8::<0>(create__m128i_from_i8_array([((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8), ((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8)]), create__m128i_from_i8_array([((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8), ((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8)])));
        check_array_equality(&result, &[0, 2, 240, 1, 248, 1, 232, 1, 240, 1, 232, 1, 248, 1, 240, 1]).map_err(|e| format!("{e} | call: _mm_mpsadbw_epu8::<0>(create__m128i_from_i8_array([((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8), ((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8)]), create__m128i_from_i8_array([((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8), ((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mpsadbw_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mpsadbw_epu8_normal2() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_mpsadbw_epu8_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_mpsadbw_epu8_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mpsadbw_epu8::<0>(create__m128i_from_i8_array([((100u8) as i8), ((200u8) as i8), ((44u8) as i8), ((144u8) as i8), ((244u8) as i8), ((88u8) as i8), ((188u8) as i8), ((32u8) as i8), ((132u8) as i8), ((232u8) as i8), ((76u8) as i8), ((176u8) as i8), ((20u8) as i8), ((120u8) as i8), ((220u8) as i8), ((64u8) as i8)]), create__m128i_from_i8_array([((110u8) as i8), ((210u8) as i8), ((54u8) as i8), ((154u8) as i8), ((254u8) as i8), ((98u8) as i8), ((198u8) as i8), ((42u8) as i8), ((142u8) as i8), ((242u8) as i8), ((86u8) as i8), ((186u8) as i8), ((30u8) as i8), ((130u8) as i8), ((230u8) as i8), ((74u8) as i8)])));
        check_array_equality(&result, &[40, 0, 180, 1, 132, 1, 136, 0, 0, 2, 88, 0, 156, 1, 156, 1]).map_err(|e| format!("{e} | call: _mm_mpsadbw_epu8::<0>(create__m128i_from_i8_array([((100u8) as i8), ((200u8) as i8), ((44u8) as i8), ((144u8) as i8), ((244u8) as i8), ((88u8) as i8), ((188u8) as i8), ((32u8) as i8), ((132u8) as i8), ((232u8) as i8), ((76u8) as i8), ((176u8) as i8), ((20u8) as i8), ((120u8) as i8), ((220u8) as i8), ((64u8) as i8)]), create__m128i_from_i8_array([((110u8) as i8), ((210u8) as i8), ((54u8) as i8), ((154u8) as i8), ((254u8) as i8), ((98u8) as i8), ((198u8) as i8), ((42u8) as i8), ((142u8) as i8), ((242u8) as i8), ((86u8) as i8), ((186u8) as i8), ((30u8) as i8), ((130u8) as i8), ((230u8) as i8), ((74u8) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mpsadbw_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mpsadbw_epu8_normal3() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_mpsadbw_epu8_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_mpsadbw_epu8_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mpsadbw_epu8::<0>(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_mpsadbw_epu8::<0>(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mpsadbw_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mpsadbw_epu8_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_mpsadbw_epu8_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_mpsadbw_epu8_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mpsadbw_epu8::<0>(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_mpsadbw_epu8::<0>(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mpsadbw_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mpsadbw_epu8_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_mpsadbw_epu8_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_mpsadbw_epu8_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mpsadbw_epu8::<0>(create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_mpsadbw_epu8::<0>(create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mpsadbw_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mpsadbw_epu8_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_mpsadbw_epu8_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_mpsadbw_epu8_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mpsadbw_epu8::<0>(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_mpsadbw_epu8::<0>(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mpsadbw_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mpsadbw_epu8_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_mpsadbw_epu8_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_mpsadbw_epu8_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mpsadbw_epu8::<0>(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3]).map_err(|e| format!("{e} | call: _mm_mpsadbw_epu8::<0>(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mpsadbw_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mpsadbw_epu8_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_mpsadbw_epu8_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_mpsadbw_epu8_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mpsadbw_epu8::<0>(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3]).map_err(|e| format!("{e} | call: _mm_mpsadbw_epu8::<0>(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mpsadbw_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mpsadbw_epu8_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_mpsadbw_epu8_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_mpsadbw_epu8_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mpsadbw_epu8::<0>(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)])));
        check_array_equality(&result, &[252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3]).map_err(|e| format!("{e} | call: _mm_mpsadbw_epu8::<0>(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mpsadbw_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mpsadbw_epu8_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_mpsadbw_epu8_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_mpsadbw_epu8_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mpsadbw_epu8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 0, 7, 0, 7, 0, 7, 0, 3, 0, 8, 0, 8, 0, 8, 0]).map_err(|e| format!("{e} | call: _mm_mpsadbw_epu8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mpsadbw_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mpsadbw_epu8_imm_0() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_mpsadbw_epu8_imm_0_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_mpsadbw_epu8_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mpsadbw_epu8::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 8, 0, 8, 0, 8, 0, 4, 0, 9, 0, 9, 0, 9, 0]).map_err(|e| format!("{e} | call: _mm_mpsadbw_epu8::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mpsadbw_epu8::<1>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mpsadbw_epu8_imm_1() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_mpsadbw_epu8_imm_1_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_testnzc_si128(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_testnzc_si128() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_testnzc_si128(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_testnzc_si128_normal2() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_testnzc_si128(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_testnzc_si128_normal3() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_si128(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_testnzc_si128_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_si128(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_testnzc_si128_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_si128(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_testnzc_si128_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_si128(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_testnzc_si128_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_si128(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_testnzc_si128_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_si128(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_testnzc_si128_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_si128(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_testnzc_si128_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_test_mix_ones_zeros_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_test_mix_ones_zeros(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_test_mix_ones_zeros(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_test_mix_ones_zeros(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_test_mix_ones_zeros() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_test_mix_ones_zeros_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_test_mix_ones_zeros_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_test_mix_ones_zeros(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_test_mix_ones_zeros(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_test_mix_ones_zeros(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_test_mix_ones_zeros_normal2() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_test_mix_ones_zeros_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_test_mix_ones_zeros_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_test_mix_ones_zeros(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_test_mix_ones_zeros(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_test_mix_ones_zeros(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_test_mix_ones_zeros_normal3() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_test_mix_ones_zeros_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_test_mix_ones_zeros_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_test_mix_ones_zeros(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_test_mix_ones_zeros(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_test_mix_ones_zeros(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_test_mix_ones_zeros_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_test_mix_ones_zeros_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_test_mix_ones_zeros_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_test_mix_ones_zeros(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_test_mix_ones_zeros(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_test_mix_ones_zeros(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_test_mix_ones_zeros_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_test_mix_ones_zeros_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_test_mix_ones_zeros_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_test_mix_ones_zeros(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_test_mix_ones_zeros(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_test_mix_ones_zeros(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_test_mix_ones_zeros_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_test_mix_ones_zeros_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_test_mix_ones_zeros_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_test_mix_ones_zeros(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_test_mix_ones_zeros(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_test_mix_ones_zeros(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_test_mix_ones_zeros_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_test_mix_ones_zeros_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_test_mix_ones_zeros_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_test_mix_ones_zeros(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_test_mix_ones_zeros(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_test_mix_ones_zeros(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_test_mix_ones_zeros_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_test_mix_ones_zeros_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_test_mix_ones_zeros_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_test_mix_ones_zeros(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_test_mix_ones_zeros(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_test_mix_ones_zeros(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_test_mix_ones_zeros_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_test_mix_ones_zeros_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_test_mix_ones_zeros_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_test_mix_ones_zeros(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_test_mix_ones_zeros(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_test_mix_ones_zeros(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_test_mix_ones_zeros_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_test_mix_ones_zeros_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_stream_load_si128_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let result = unpack__m128i_to_i32_array(_mm_stream_load_si128(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: _mm_stream_load_si128(ptr_mem_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_stream_load_si128() -> Result<(), String> {
    unsafe { test_x86_sse41_mm_stream_load_si128_impl() }
}
