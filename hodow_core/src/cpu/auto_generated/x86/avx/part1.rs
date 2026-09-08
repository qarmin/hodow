#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_avx_mm256_max_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_max_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm256_max_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_max_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64])));
        check_float_array_equality(&result, &[10.0, 9.0, 12.0, 7.0]).map_err(|e| format!("{e} | call: _mm256_max_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_max_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64])));
        check_float_array_equality(&result, &[110.0, 210.0, 310.0, 410.0]).map_err(|e| format!("{e} | call: _mm256_max_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_max_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_max_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_max_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_max_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_max_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_max_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_max_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_max_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_max_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm256_max_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_max_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_max_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_max_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_max_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_max_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]).map_err(|e| format!("{e} | call: _mm256_max_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_max_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[10.0, 9.0, 12.0, 7.0, 14.0, 5.0, 16.0, 3.0]).map_err(|e| format!("{e} | call: _mm256_max_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_max_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32])));
        check_float_array_equality(&result, &[110.0, 210.0, 310.0, 410.0, 510.0, 610.0, 710.0, 810.0]).map_err(|e| format!("{e} | call: _mm256_max_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_max_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_max_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_max_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_max_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_max_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_max_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_max_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_max_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_max_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_max_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_max_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_max_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_max_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_max_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_max_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_max_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_min_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_min_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_min_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm256_min_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_min_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm256_min_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_min_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_min_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_min_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_min_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_min_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_min_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_min_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_min_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_min_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm256_min_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_min_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_min_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_min_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_min_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_min_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm256_min_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_min_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| format!("{e} | call: _mm256_min_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_min_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0]).map_err(|e| format!("{e} | call: _mm256_min_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_min_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_min_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_min_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_min_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_min_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_min_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_min_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_min_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_min_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_min_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_min_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_min_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_min_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_min_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_min_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_min_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_round_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_round_pd::<8>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_round_pd::<8>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_round_pd::<8>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_round_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_round_pd::<8>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm256_round_pd::<8>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_round_pd::<8>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_round_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_round_pd::<8>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm256_round_pd::<8>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_round_pd::<8>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_round_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_round_pd::<8>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_round_pd::<8>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_round_pd::<8>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_round_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_round_pd::<8>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_round_pd::<8>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_round_pd::<8>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_round_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_round_pd::<8>(create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_round_pd::<8>(create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_round_pd::<8>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_round_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_round_pd::<8>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_round_pd::<8>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_round_pd::<8>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_round_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_round_pd::<8>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_round_pd::<8>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_round_pd::<8>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_round_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_round_ps::<8>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm256_round_ps::<8>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_round_ps::<8>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_round_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_round_ps::<8>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| format!("{e} | call: _mm256_round_ps::<8>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_round_ps::<8>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_round_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_round_ps::<8>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0]).map_err(|e| format!("{e} | call: _mm256_round_ps::<8>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_round_ps::<8>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_round_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_round_ps::<8>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_round_ps::<8>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_round_ps::<8>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_round_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_round_ps::<8>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_round_ps::<8>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_round_ps::<8>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_round_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_round_ps::<8>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_round_ps::<8>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_round_ps::<8>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_round_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_round_ps::<8>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_round_ps::<8>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_round_ps::<8>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_round_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_round_ps::<8>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 0.0, f32::INFINITY, -f32::INFINITY, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_round_ps::<8>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_round_ps::<8>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_sqrt_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_sqrt_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 1.4142135, 1.7320508, 2.0, 2.236068, 2.4494898, 2.6457512, 2.828427]).map_err(|e| format!("{e} | call: _mm256_sqrt_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sqrt_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_sqrt_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_sqrt_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_float_array_equality(&result, &[0.0, f32::NAN, 1.4142135, f32::NAN, 2.0, f32::NAN, 2.4494898, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_sqrt_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sqrt_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_sqrt_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_sqrt_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32])));
        check_float_array_equality(&result, &[10.0, 14.142136, 17.320509, 20.0, 22.36068, 24.494898, 26.457514, 28.284271]).map_err(|e| format!("{e} | call: _mm256_sqrt_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sqrt_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_sqrt_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_sqrt_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_sqrt_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sqrt_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_sqrt_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_sqrt_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.8446743e19, 1.8446743e19, 1.8446743e19, 1.8446743e19, 1.8446743e19, 1.8446743e19, 1.8446743e19, 1.8446743e19]).map_err(|e| format!("{e} | call: _mm256_sqrt_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sqrt_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_sqrt_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_sqrt_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_sqrt_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sqrt_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_sqrt_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_sqrt_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_sqrt_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sqrt_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_sqrt_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_sqrt_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::NAN, -0.0, 7.666467e-20, f32::INFINITY, f32::NAN, -0.0, 7.666467e-20]).map_err(|e| format!("{e} | call: _mm256_sqrt_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sqrt_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_sqrt_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_sqrt_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 1.4142135623730951, 1.7320508075688772, 2.0]).map_err(|e| format!("{e} | call: _mm256_sqrt_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sqrt_pd(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_sqrt_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_sqrt_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64])));
        check_float_array_equality(&result, &[0.0, f64::NAN, 1.4142135623730951, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_sqrt_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sqrt_pd(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_sqrt_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_sqrt_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64])));
        check_float_array_equality(&result, &[10.0, 14.142135623730951, 17.320508075688775, 20.0]).map_err(|e| format!("{e} | call: _mm256_sqrt_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sqrt_pd(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_sqrt_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_sqrt_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_sqrt_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sqrt_pd(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_sqrt_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_sqrt_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.3407807929942596e154, 1.3407807929942596e154, 1.3407807929942596e154, 1.3407807929942596e154]).map_err(|e| format!("{e} | call: _mm256_sqrt_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sqrt_pd(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_sqrt_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_sqrt_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_sqrt_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sqrt_pd(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_sqrt_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_sqrt_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_sqrt_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sqrt_pd(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_sqrt_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_sqrt_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::NAN, -0.0, 1.0547686614863e-154]).map_err(|e| format!("{e} | call: _mm256_sqrt_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sqrt_pd(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_dp_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dp_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_dp_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_dp_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dp_ps::<0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_dp_ps::<0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_dp_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dp_ps::<0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_dp_ps::<0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_dp_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dp_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_dp_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_dp_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dp_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_dp_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_dp_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dp_ps::<0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_dp_ps::<0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_dp_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dp_ps::<0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_dp_ps::<0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_dp_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dp_ps::<0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_dp_ps::<0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_dp_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dp_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_dp_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_dp_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dp_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_dp_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_dp_ps_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dp_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_dp_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_dp_ps_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dp_ps::<1>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_dp_ps::<1>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dp_ps::<1>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmp_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_pd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmp_pd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_pd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmp_pd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmp_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmp_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_pd::<0>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmp_pd::<0>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmp_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmp_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmp_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmp_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_pd_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmp_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_pd_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_pd::<1>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmp_pd::<1>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_pd::<1>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_cmp_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_cmp_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_cmp_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_cmp_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_cmp_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_cmp_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_cmp_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_cmp_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_cmp_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_cmp_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_cmp_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_cmp_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_cmp_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_cmp_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_cmp_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_cmp_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_cmp_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_cmp_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_cmp_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_cmp_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_pd_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_cmp_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_cmp_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_pd_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_cmp_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_cmp_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_pd::<1>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmp_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmp_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmp_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmp_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmp_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmp_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmp_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmp_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmp_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmp_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ps_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmp_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ps_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmp_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ps::<1>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_cmp_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_cmp_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_cmp_ps::<0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_cmp_ps::<0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_cmp_ps::<0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_cmp_ps::<0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_cmp_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_cmp_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_cmp_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_cmp_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_cmp_ps::<0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_cmp_ps::<0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_cmp_ps::<0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_cmp_ps::<0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_cmp_ps::<0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_cmp_ps::<0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_cmp_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_cmp_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_cmp_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_cmp_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_ps_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_cmp_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_cmp_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cmp_ps_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_cmp_ps::<1>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_cmp_ps::<1>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cmp_ps::<1>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_sd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0, 2.0]).map_err(|e| format!("{e} | call: _mm_cmp_sd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_sd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| format!("{e} | call: _mm_cmp_sd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_sd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[0.0, 200.0]).map_err(|e| format!("{e} | call: _mm_cmp_sd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_sd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmp_sd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_sd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmp_sd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_sd::<0>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm_cmp_sd::<0>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_sd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[0.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmp_sd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_sd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cmp_sd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_sd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmp_sd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_sd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmp_sd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_sd_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_sd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0, 2.0]).map_err(|e| format!("{e} | call: _mm_cmp_sd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_sd_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_sd::<1>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[f64::NAN, 2.0]).map_err(|e| format!("{e} | call: _mm_cmp_sd::<1>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_sd::<1>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cmp_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ss_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ss::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cmp_ss::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ss_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ss::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[0.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cmp_ss::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ss_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ss::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmp_ss::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ss_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ss::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmp_ss::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ss_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ss::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cmp_ss::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ss_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ss::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[0.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmp_ss::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ss_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ss::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cmp_ss::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ss_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ss::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmp_ss::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ss_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ss::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmp_ss::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ss_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cmp_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_cmp_ss_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ss::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::NAN, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cmp_ss::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmp_ss::<1>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cvtps_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtps_epi32(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm256_cvtps_epi32(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtps_epi32(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cvttpd_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvttpd_epi32(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: _mm256_cvttpd_epi32(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvttpd_epi32(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cvtpd_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtpd_epi32(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: _mm256_cvtpd_epi32(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtpd_epi32(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cvttps_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvttps_epi32(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm256_cvttps_epi32(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvttps_epi32(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_zeroall() -> Result<(), String> {
    unsafe {
        _mm256_zeroall();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                _mm256_zeroall();
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_zeroupper() -> Result<(), String> {
    unsafe {
        _mm256_zeroupper();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                _mm256_zeroupper();
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_permutevar_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permutevar_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[2.0, 3.0, 4.0, 1.0, 6.0, 7.0, 8.0, 5.0]).map_err(|e| format!("{e} | call: _mm256_permutevar_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutevar_ps(create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_permutevar_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permutevar_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-1.0, 2.0, -3.0, 0.0, -5.0, 6.0, -7.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_permutevar_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutevar_ps(create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_permutevar_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permutevar_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[200.0, 300.0, 400.0, 100.0, 600.0, 700.0, 800.0, 500.0]).map_err(|e| format!("{e} | call: _mm256_permutevar_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutevar_ps(create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_permutevar_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permutevar_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_permutevar_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutevar_ps(create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_permutevar_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permutevar_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_permutevar_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutevar_ps(create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_permutevar_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permutevar_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_permutevar_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutevar_ps(create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_permutevar_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permutevar_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_permutevar_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutevar_ps(create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_permutevar_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permutevar_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_permutevar_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutevar_ps(create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_permutevar_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permutevar_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_float_array_equality(&result, &[2.0, 3.0, 4.0, 1.0]).map_err(|e| format!("{e} | call: _mm_permutevar_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutevar_ps(create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_permutevar_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permutevar_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[-1.0, 2.0, -3.0, 0.0]).map_err(|e| format!("{e} | call: _mm_permutevar_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutevar_ps(create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_permutevar_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permutevar_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[200.0, 300.0, 400.0, 100.0]).map_err(|e| format!("{e} | call: _mm_permutevar_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutevar_ps(create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_permutevar_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permutevar_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_permutevar_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutevar_ps(create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_permutevar_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permutevar_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_permutevar_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutevar_ps(create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_permutevar_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permutevar_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_permutevar_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutevar_ps(create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_permutevar_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permutevar_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_permutevar_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutevar_ps(create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_permutevar_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permutevar_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[-f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_permutevar_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutevar_ps(create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_permutevar_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutevar_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_permutevar_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutevar_pd(create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_permutevar_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutevar_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm256_permutevar_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutevar_pd(create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_permutevar_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutevar_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm256_permutevar_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutevar_pd(create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_permutevar_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutevar_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_permutevar_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutevar_pd(create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_permutevar_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutevar_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_permutevar_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutevar_pd(create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_permutevar_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutevar_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_permutevar_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutevar_pd(create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_permutevar_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutevar_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_permutevar_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutevar_pd(create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_permutevar_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutevar_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm256_permutevar_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutevar_pd(create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_permutevar_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permutevar_pd(create__m128d_from([1.0, 2.0]), create__m128i_from_i32_array([3, 4, 5, 6])));
        check_float_array_equality(&result, &[2.0, 1.0]).map_err(|e| format!("{e} | call: _mm_permutevar_pd(create__m128d_from([1.0, 2.0]), create__m128i_from_i32_array([3, 4, 5, 6]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutevar_pd(create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_permutevar_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permutevar_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| format!("{e} | call: _mm_permutevar_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutevar_pd(create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_permutevar_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permutevar_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[100.0, 200.0]).map_err(|e| format!("{e} | call: _mm_permutevar_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutevar_pd(create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_permutevar_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permutevar_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_permutevar_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutevar_pd(create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_permutevar_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permutevar_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_permutevar_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutevar_pd(create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_permutevar_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permutevar_pd(create__m128d_from([0.0, 0.0]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_permutevar_pd(create__m128d_from([0.0, 0.0]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutevar_pd(create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_permutevar_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permutevar_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_permutevar_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutevar_pd(create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_permutevar_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permutevar_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_permutevar_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutevar_pd(create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_lddqu_si256() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]); 2]);
        let result = unpack__m256i_to_i32_array(_mm256_lddqu_si256(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm256_lddqu_si256(ptr_mem_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_si256() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]); 2]);
        let a = create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]);
        _mm256_stream_si256(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_si256_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]); 2]);
        let a = create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_stream_si256(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_si256_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]); 2]);
        let a = create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]);
        _mm256_stream_si256(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_si256_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]); 2]);
        let a = create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm256_stream_si256(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_si256_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]); 2]);
        let a = create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm256_stream_si256(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_si256_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]); 2]);
        let a = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_stream_si256(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_si256_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]); 2]);
        let a = create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_stream_si256(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_si256_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]); 2]);
        let a = create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]);
        _mm256_stream_si256(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m256d_from([2.0, 3.0, 4.0, 5.0]);
        _mm256_stream_pd(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]);
        _mm256_stream_pd(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]);
        _mm256_stream_pd(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]);
        _mm256_stream_pd(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]);
        _mm256_stream_pd(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m256d_from([0.0, 0.0, 0.0, 0.0]);
        _mm256_stream_pd(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]);
        _mm256_stream_pd(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]);
        _mm256_stream_pd(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m256_from([2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]);
        _mm256_stream_ps(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]);
        _mm256_stream_ps(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]);
        _mm256_stream_ps(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        _mm256_stream_ps(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        _mm256_stream_ps(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]);
        _mm256_stream_ps(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        _mm256_stream_ps(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_stream_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        _mm256_stream_ps(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_rcp_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_rcp_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.99975586, 0.49987793, 0.333313, 0.24993896, 0.19995117, 0.1666565, 0.14282227, 0.12496948]).map_err(|e| format!("{e} | call: _mm256_rcp_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_rcp_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_rcp_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_rcp_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_float_array_equality(&result, &[f32::INFINITY, -0.99975586, 0.49987793, -0.333313, 0.24993896, -0.19995117, 0.1666565, -0.14282227]).map_err(|e| format!("{e} | call: _mm256_rcp_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_rcp_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_rcp_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_rcp_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32])));
        check_float_array_equality(&result, &[0.0099983215, 0.0049991608, 0.0033330917, 0.0024995804, 0.001999855, 0.0016665459, 0.0014286041, 0.0012497902]).map_err(|e| format!("{e} | call: _mm256_rcp_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_rcp_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_rcp_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_rcp_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_rcp_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_rcp_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_rcp_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_rcp_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_rcp_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_rcp_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_rcp_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_rcp_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_rcp_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_rcp_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_rcp_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_rcp_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_rcp_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_rcp_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_rcp_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_rcp_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0, -0.0, -f32::INFINITY, f32::INFINITY, 0.0, -0.0, -f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_rcp_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_rcp_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_rsqrt_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_rsqrt_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.9998779, 0.70703125, 0.5772705, 0.49993896, 0.44714355, 0.40826416, 0.3779297, 0.35351563]).map_err(|e| format!("{e} | call: _mm256_rsqrt_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_rsqrt_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_rsqrt_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_rsqrt_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::NAN, 0.70703125, f32::NAN, 0.49993896, f32::NAN, 0.40826416, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_rsqrt_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_rsqrt_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_rsqrt_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_rsqrt_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32])));
        check_float_array_equality(&result, &[0.099990845, 0.07070923, 0.05773163, 0.049995422, 0.04471588, 0.04082489, 0.03779602, 0.035354614]).map_err(|e| format!("{e} | call: _mm256_rsqrt_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_rsqrt_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_rsqrt_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_rsqrt_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_rsqrt_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_rsqrt_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_rsqrt_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_rsqrt_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_rsqrt_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_rsqrt_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_rsqrt_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_rsqrt_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_rsqrt_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_rsqrt_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_rsqrt_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_rsqrt_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_rsqrt_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_rsqrt_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_rsqrt_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_rsqrt_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0, f32::NAN, -f32::INFINITY, f32::INFINITY, 0.0, f32::NAN, -f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_rsqrt_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_rsqrt_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_si256() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_si256(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testnzc_si256(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_si256(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_si256_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_si256(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testnzc_si256(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_si256(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_si256_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_si256(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testnzc_si256(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_si256(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_si256_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_si256(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_si256(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_si256(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_si256_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_si256(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_si256(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_si256(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_si256_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_si256(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_si256(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_si256(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_si256_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_si256(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_si256(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_si256(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_si256_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_si256(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_si256(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_si256(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_si256_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_si256(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_si256(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_si256(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_si256_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_si256(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_si256(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_si256(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_pd() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testz_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testz_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testz_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testz_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testz_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testz_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testz_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testz_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testz_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testz_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_pd() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testc_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testc_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testc_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testc_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testc_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testc_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testc_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testc_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testc_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testc_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_pd() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_ps() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testz_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testz_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testz_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testz_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testz_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testz_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testz_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testz_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testz_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testz_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testz_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_ps() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testc_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testc_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testc_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testc_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testc_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testc_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testc_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testc_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_testc_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testc_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = _mm256_testc_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testc_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_ps() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_testnzc_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = _mm256_testnzc_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_testnzc_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_testnzc_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_ps() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm_testnzc_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_testnzc_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_testnzc_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}
