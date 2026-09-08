#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_fma_mm_fmadd_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[8.0, 14.0]).map_err(|e| format!("{e} | call: _mm_fmadd_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64])));
        check_float_array_equality(&result, &[20.0, 10.0]).map_err(|e| format!("{e} | call: _mm_fmadd_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64])));
        check_float_array_equality(&result, &[11120.0, 42220.0]).map_err(|e| format!("{e} | call: _mm_fmadd_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmadd_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmadd_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_fmadd_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_fmadd_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::NAN]).map_err(|e| format!("{e} | call: _mm_fmadd_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmadd_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmadd_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmadd_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[14.0, 22.0, 32.0, 44.0]).map_err(|e| format!("{e} | call: _mm256_fmadd_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmadd_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64])));
        check_float_array_equality(&result, &[20.0, 10.0, 46.0, -4.0]).map_err(|e| format!("{e} | call: _mm256_fmadd_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmadd_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64])));
        check_float_array_equality(&result, &[11120.0, 42220.0, 93320.0, 164420.0]).map_err(|e| format!("{e} | call: _mm256_fmadd_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmadd_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmadd_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmadd_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmadd_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmadd_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_fmadd_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmadd_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_fmadd_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmadd_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::NAN, 0.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm256_fmadd_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmadd_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmadd_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmadd_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmadd_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[14.0, 22.0, 32.0, 44.0]).map_err(|e| format!("{e} | call: _mm_fmadd_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32])));
        check_float_array_equality(&result, &[20.0, 10.0, 46.0, -4.0]).map_err(|e| format!("{e} | call: _mm_fmadd_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32])));
        check_float_array_equality(&result, &[11120.0, 42220.0, 93320.0, 164420.0]).map_err(|e| format!("{e} | call: _mm_fmadd_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmadd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmadd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_fmadd_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_fmadd_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::NAN, 0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_fmadd_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmadd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmadd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmadd_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_float_array_equality(&result, &[26.0, 38.0, 52.0, 68.0, 86.0, 106.0, 128.0, 152.0]).map_err(|e| format!("{e} | call: _mm256_fmadd_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmadd_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32])));
        check_float_array_equality(&result, &[20.0, 10.0, 46.0, -4.0, 80.0, -10.0, 122.0, -8.0]).map_err(|e| format!("{e} | call: _mm256_fmadd_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmadd_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32])));
        check_float_array_equality(&result, &[11120.0, 42220.0, 93320.0, 164420.0, 255520.0, 366620.0, 497720.0, 648820.0]).map_err(|e| format!("{e} | call: _mm256_fmadd_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmadd_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmadd_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmadd_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmadd_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmadd_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_fmadd_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmadd_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_fmadd_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmadd_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::NAN, 0.0, 5.877472e-39, f32::INFINITY, f32::NAN, 0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_fmadd_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmadd_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmadd_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmadd_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmadd_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmadd_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[8.0, 2.0]).map_err(|e| format!("{e} | call: _mm_fmadd_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64])));
        check_float_array_equality(&result, &[20.0, -1.0]).map_err(|e| format!("{e} | call: _mm_fmadd_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64])));
        check_float_array_equality(&result, &[11120.0, 200.0]).map_err(|e| format!("{e} | call: _mm_fmadd_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fmadd_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fmadd_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_fmadd_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_fmadd_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmadd_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fmadd_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fmadd_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[14.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_fmadd_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ss_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32])));
        check_float_array_equality(&result, &[20.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_fmadd_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ss_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32])));
        check_float_array_equality(&result, &[11120.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_fmadd_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ss_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fmadd_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ss_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fmadd_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ss_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_fmadd_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ss_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_fmadd_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ss_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_fmadd_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ss_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fmadd_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmadd_ss_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fmadd_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmaddsub_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[-2.0, 14.0]).map_err(|e| format!("{e} | call: _mm_fmaddsub_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmaddsub_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64])));
        check_float_array_equality(&result, &[-20.0, 10.0]).map_err(|e| format!("{e} | call: _mm_fmaddsub_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmaddsub_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64])));
        check_float_array_equality(&result, &[10880.0, 42220.0]).map_err(|e| format!("{e} | call: _mm_fmaddsub_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmaddsub_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmaddsub_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmaddsub_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmaddsub_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmaddsub_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_fmaddsub_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmaddsub_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_fmaddsub_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmaddsub_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_fmaddsub_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmaddsub_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmaddsub_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmaddsub_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmaddsub_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmaddsub_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[-4.0, 22.0, 10.0, 44.0]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmaddsub_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64])));
        check_float_array_equality(&result, &[-20.0, 10.0, 2.0, -4.0]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmaddsub_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64])));
        check_float_array_equality(&result, &[10880.0, 42220.0, 92680.0, 164420.0]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmaddsub_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmaddsub_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmaddsub_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmaddsub_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmaddsub_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, 0.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmaddsub_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmaddsub_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmaddsub_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[-4.0, 22.0, 10.0, 44.0]).map_err(|e| format!("{e} | call: _mm_fmaddsub_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmaddsub_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32])));
        check_float_array_equality(&result, &[-20.0, 10.0, 2.0, -4.0]).map_err(|e| format!("{e} | call: _mm_fmaddsub_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmaddsub_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32])));
        check_float_array_equality(&result, &[10880.0, 42220.0, 92680.0, 164420.0]).map_err(|e| format!("{e} | call: _mm_fmaddsub_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmaddsub_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmaddsub_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmaddsub_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmaddsub_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmaddsub_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_fmaddsub_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmaddsub_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_fmaddsub_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmaddsub_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, 0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_fmaddsub_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmaddsub_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmaddsub_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmaddsub_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmaddsub_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmaddsub_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmaddsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmaddsub_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_float_array_equality(&result, &[-8.0, 38.0, 14.0, 68.0, 44.0, 106.0, 82.0, 152.0]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmaddsub_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32])));
        check_float_array_equality(&result, &[-20.0, 10.0, 2.0, -4.0, 32.0, -10.0, 70.0, -8.0]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmaddsub_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32])));
        check_float_array_equality(&result, &[10880.0, 42220.0, 92680.0, 164420.0, 254480.0, 366620.0, 496280.0, 648820.0]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmaddsub_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmaddsub_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmaddsub_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmaddsub_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmaddsub_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, 0.0, 5.877472e-39, f32::NAN, f32::NAN, 0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmaddsub_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmaddsub_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmaddsub_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmaddsub_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmaddsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[-2.0, 2.0]).map_err(|e| format!("{e} | call: _mm_fmsub_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64])));
        check_float_array_equality(&result, &[-20.0, -28.0]).map_err(|e| format!("{e} | call: _mm_fmsub_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64])));
        check_float_array_equality(&result, &[10880.0, 41780.0]).map_err(|e| format!("{e} | call: _mm_fmsub_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsub_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsub_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_fmsub_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_fmsub_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsub_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsub_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsub_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsub_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[-4.0, 2.0, 10.0, 20.0]).map_err(|e| format!("{e} | call: _mm256_fmsub_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsub_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64])));
        check_float_array_equality(&result, &[-20.0, -28.0, 2.0, -38.0]).map_err(|e| format!("{e} | call: _mm256_fmsub_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsub_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64])));
        check_float_array_equality(&result, &[10880.0, 41780.0, 92680.0, 163580.0]).map_err(|e| format!("{e} | call: _mm256_fmsub_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsub_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmsub_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsub_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmsub_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsub_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_fmsub_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsub_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_fmsub_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsub_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::INFINITY, 0.0, -1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm256_fmsub_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsub_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmsub_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsub_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmsub_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[-4.0, 2.0, 10.0, 20.0]).map_err(|e| format!("{e} | call: _mm_fmsub_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32])));
        check_float_array_equality(&result, &[-20.0, -28.0, 2.0, -38.0]).map_err(|e| format!("{e} | call: _mm_fmsub_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32])));
        check_float_array_equality(&result, &[10880.0, 41780.0, 92680.0, 163580.0]).map_err(|e| format!("{e} | call: _mm_fmsub_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsub_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsub_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_fmsub_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_fmsub_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::INFINITY, 0.0, -5.877472e-39]).map_err(|e| format!("{e} | call: _mm_fmsub_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsub_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsub_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsub_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_float_array_equality(&result, &[-8.0, 2.0, 14.0, 28.0, 44.0, 62.0, 82.0, 104.0]).map_err(|e| format!("{e} | call: _mm256_fmsub_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsub_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32])));
        check_float_array_equality(&result, &[-20.0, -28.0, 2.0, -38.0, 32.0, -40.0, 70.0, -34.0]).map_err(|e| format!("{e} | call: _mm256_fmsub_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsub_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32])));
        check_float_array_equality(&result, &[10880.0, 41780.0, 92680.0, 163580.0, 254480.0, 365380.0, 496280.0, 647180.0]).map_err(|e| format!("{e} | call: _mm256_fmsub_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsub_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmsub_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsub_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmsub_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsub_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_fmsub_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsub_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_fmsub_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsub_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::INFINITY, 0.0, -5.877472e-39, f32::NAN, f32::INFINITY, 0.0, -5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_fmsub_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsub_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmsub_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsub_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsub_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmsub_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[-2.0, 2.0]).map_err(|e| format!("{e} | call: _mm_fmsub_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64])));
        check_float_array_equality(&result, &[-20.0, -1.0]).map_err(|e| format!("{e} | call: _mm_fmsub_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64])));
        check_float_array_equality(&result, &[10880.0, 200.0]).map_err(|e| format!("{e} | call: _mm_fmsub_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fmsub_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fmsub_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_fmsub_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_fmsub_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsub_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fmsub_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fmsub_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[-4.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_fmsub_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ss_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32])));
        check_float_array_equality(&result, &[-20.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_fmsub_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ss_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32])));
        check_float_array_equality(&result, &[10880.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_fmsub_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ss_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fmsub_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ss_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fmsub_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ss_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_fmsub_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ss_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_fmsub_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ss_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_fmsub_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ss_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fmsub_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsub_ss_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fmsub_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[8.0, 2.0]).map_err(|e| format!("{e} | call: _mm_fmsubadd_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64])));
        check_float_array_equality(&result, &[20.0, -28.0]).map_err(|e| format!("{e} | call: _mm_fmsubadd_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64])));
        check_float_array_equality(&result, &[11120.0, 41780.0]).map_err(|e| format!("{e} | call: _mm_fmsubadd_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsubadd_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsubadd_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_fmsubadd_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_fmsubadd_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsubadd_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsubadd_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsubadd_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[14.0, 2.0, 32.0, 20.0]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64])));
        check_float_array_equality(&result, &[20.0, -28.0, 46.0, -38.0]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64])));
        check_float_array_equality(&result, &[11120.0, 41780.0, 93320.0, 163580.0]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, 0.0, -1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[14.0, 2.0, 32.0, 20.0]).map_err(|e| format!("{e} | call: _mm_fmsubadd_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32])));
        check_float_array_equality(&result, &[20.0, -28.0, 46.0, -38.0]).map_err(|e| format!("{e} | call: _mm_fmsubadd_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32])));
        check_float_array_equality(&result, &[11120.0, 41780.0, 93320.0, 163580.0]).map_err(|e| format!("{e} | call: _mm_fmsubadd_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsubadd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsubadd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_fmsubadd_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_fmsubadd_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, 0.0, -5.877472e-39]).map_err(|e| format!("{e} | call: _mm_fmsubadd_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsubadd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fmsubadd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_float_array_equality(&result, &[26.0, 2.0, 52.0, 28.0, 86.0, 62.0, 128.0, 104.0]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32])));
        check_float_array_equality(&result, &[20.0, -28.0, 46.0, -38.0, 80.0, -40.0, 122.0, -34.0]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32])));
        check_float_array_equality(&result, &[11120.0, 41780.0, 93320.0, 163580.0, 255520.0, 365380.0, 497720.0, 647180.0]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, 0.0, -5.877472e-39, f32::INFINITY, f32::INFINITY, 0.0, -5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fmsubadd_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[2.0, -2.0]).map_err(|e| format!("{e} | call: _mm_fnmadd_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64])));
        check_float_array_equality(&result, &[20.0, 28.0]).map_err(|e| format!("{e} | call: _mm_fnmadd_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64])));
        check_float_array_equality(&result, &[-10880.0, -41780.0]).map_err(|e| format!("{e} | call: _mm_fnmadd_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmadd_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmadd_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_fnmadd_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_fnmadd_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmadd_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmadd_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmadd_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmadd_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[4.0, -2.0, -10.0, -20.0]).map_err(|e| format!("{e} | call: _mm256_fnmadd_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmadd_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64])));
        check_float_array_equality(&result, &[20.0, 28.0, -2.0, 38.0]).map_err(|e| format!("{e} | call: _mm256_fnmadd_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmadd_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64])));
        check_float_array_equality(&result, &[-10880.0, -41780.0, -92680.0, -163580.0]).map_err(|e| format!("{e} | call: _mm256_fnmadd_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmadd_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fnmadd_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmadd_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fnmadd_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmadd_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_fnmadd_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmadd_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_fnmadd_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmadd_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::NAN, -f64::INFINITY, -0.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm256_fnmadd_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmadd_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fnmadd_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmadd_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fnmadd_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[4.0, -2.0, -10.0, -20.0]).map_err(|e| format!("{e} | call: _mm_fnmadd_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32])));
        check_float_array_equality(&result, &[20.0, 28.0, -2.0, 38.0]).map_err(|e| format!("{e} | call: _mm_fnmadd_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32])));
        check_float_array_equality(&result, &[-10880.0, -41780.0, -92680.0, -163580.0]).map_err(|e| format!("{e} | call: _mm_fnmadd_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmadd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmadd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_fnmadd_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_fnmadd_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_fnmadd_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmadd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmadd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmadd_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_float_array_equality(&result, &[8.0, -2.0, -14.0, -28.0, -44.0, -62.0, -82.0, -104.0]).map_err(|e| format!("{e} | call: _mm256_fnmadd_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmadd_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32])));
        check_float_array_equality(&result, &[20.0, 28.0, -2.0, 38.0, -32.0, 40.0, -70.0, 34.0]).map_err(|e| format!("{e} | call: _mm256_fnmadd_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmadd_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32])));
        check_float_array_equality(&result, &[-10880.0, -41780.0, -92680.0, -163580.0, -254480.0, -365380.0, -496280.0, -647180.0]).map_err(|e| format!("{e} | call: _mm256_fnmadd_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmadd_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fnmadd_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmadd_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fnmadd_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmadd_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_fnmadd_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmadd_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_fnmadd_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmadd_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, -f32::INFINITY, -0.0, 5.877472e-39, f32::NAN, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_fnmadd_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmadd_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fnmadd_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmadd_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmadd_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fnmadd_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[2.0, 2.0]).map_err(|e| format!("{e} | call: _mm_fnmadd_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64])));
        check_float_array_equality(&result, &[20.0, -1.0]).map_err(|e| format!("{e} | call: _mm_fnmadd_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64])));
        check_float_array_equality(&result, &[-10880.0, 200.0]).map_err(|e| format!("{e} | call: _mm_fnmadd_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-f64::INFINITY, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fnmadd_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fnmadd_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_fnmadd_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_fnmadd_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmadd_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fnmadd_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fnmadd_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[4.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_fnmadd_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ss_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32])));
        check_float_array_equality(&result, &[20.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_fnmadd_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ss_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32])));
        check_float_array_equality(&result, &[-10880.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_fnmadd_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ss_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fnmadd_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ss_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fnmadd_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ss_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_fnmadd_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ss_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_fnmadd_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ss_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_fnmadd_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ss_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fnmadd_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmadd_ss_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[f32::INFINITY, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fnmadd_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmadd_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[-8.0, -14.0]).map_err(|e| format!("{e} | call: _mm_fnmsub_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64])));
        check_float_array_equality(&result, &[-20.0, -10.0]).map_err(|e| format!("{e} | call: _mm_fnmsub_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64])));
        check_float_array_equality(&result, &[-11120.0, -42220.0]).map_err(|e| format!("{e} | call: _mm_fnmsub_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmsub_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmsub_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_fnmsub_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_fnmsub_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[-f64::INFINITY, f64::NAN]).map_err(|e| format!("{e} | call: _mm_fnmsub_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmsub_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmsub_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmsub_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[-14.0, -22.0, -32.0, -44.0]).map_err(|e| format!("{e} | call: _mm256_fnmsub_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmsub_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64])));
        check_float_array_equality(&result, &[-20.0, -10.0, -46.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_fnmsub_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmsub_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64])));
        check_float_array_equality(&result, &[-11120.0, -42220.0, -93320.0, -164420.0]).map_err(|e| format!("{e} | call: _mm256_fnmsub_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmsub_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fnmsub_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmsub_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fnmsub_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmsub_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_fnmsub_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmsub_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_fnmsub_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmsub_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, f64::NAN, 0.0, -1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm256_fnmsub_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmsub_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fnmsub_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fnmsub_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fnmsub_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[-14.0, -22.0, -32.0, -44.0]).map_err(|e| format!("{e} | call: _mm_fnmsub_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32])));
        check_float_array_equality(&result, &[-20.0, -10.0, -46.0, 4.0]).map_err(|e| format!("{e} | call: _mm_fnmsub_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32])));
        check_float_array_equality(&result, &[-11120.0, -42220.0, -93320.0, -164420.0]).map_err(|e| format!("{e} | call: _mm_fnmsub_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmsub_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmsub_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_fnmsub_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_fnmsub_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, f32::NAN, 0.0, -5.877472e-39]).map_err(|e| format!("{e} | call: _mm_fnmsub_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmsub_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmsub_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmsub_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_float_array_equality(&result, &[-26.0, -38.0, -52.0, -68.0, -86.0, -106.0, -128.0, -152.0]).map_err(|e| format!("{e} | call: _mm256_fnmsub_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmsub_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32])));
        check_float_array_equality(&result, &[-20.0, -10.0, -46.0, 4.0, -80.0, 10.0, -122.0, 8.0]).map_err(|e| format!("{e} | call: _mm256_fnmsub_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmsub_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32])));
        check_float_array_equality(&result, &[-11120.0, -42220.0, -93320.0, -164420.0, -255520.0, -366620.0, -497720.0, -648820.0]).map_err(|e| format!("{e} | call: _mm256_fnmsub_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmsub_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fnmsub_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmsub_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fnmsub_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmsub_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_fnmsub_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmsub_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_fnmsub_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmsub_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, f32::NAN, 0.0, -5.877472e-39, -f32::INFINITY, f32::NAN, 0.0, -5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_fnmsub_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmsub_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fnmsub_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm256_fnmsub_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fnmsub_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_fnmsub_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fnmsub_ps(create_random__m256(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[-8.0, 2.0]).map_err(|e| format!("{e} | call: _mm_fnmsub_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64])));
        check_float_array_equality(&result, &[-20.0, -1.0]).map_err(|e| format!("{e} | call: _mm_fnmsub_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64])));
        check_float_array_equality(&result, &[-11120.0, 200.0]).map_err(|e| format!("{e} | call: _mm_fnmsub_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-f64::INFINITY, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fnmsub_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fnmsub_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_fnmsub_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_fnmsub_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fnmsub_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fnmsub_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fnmsub_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_sd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[-14.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_fnmsub_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ss_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32])));
        check_float_array_equality(&result, &[-20.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_fnmsub_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ss_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32])));
        check_float_array_equality(&result, &[-11120.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_fnmsub_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ss_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fnmsub_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ss_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fnmsub_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ss_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_fnmsub_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ss_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_fnmsub_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ss_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_fnmsub_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ss_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fnmsub_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_fma_mm_fnmsub_ss_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[f32::INFINITY, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fnmsub_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fnmsub_ss(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}
