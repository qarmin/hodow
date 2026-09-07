use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_64_avx512f_mm_cvtsd_i64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_i64(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtsd_i64(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtsd_i64_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_i64(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_i64(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtsd_i64_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_i64(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvtsd_i64(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtsd_i64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_i64(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_i64(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtsd_i64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_i64(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_i64(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtsd_i64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_i64(create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_i64(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtsd_i64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_i64(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_i64(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtsd_i64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_i64(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_i64(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtss_i64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_i64(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtss_i64(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtss_i64_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_i64(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtss_i64(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtss_i64_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_i64(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvtss_i64(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtss_i64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_i64(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtss_i64(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtss_i64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_i64(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtss_i64(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtss_i64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_i64(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtss_i64(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtss_i64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_i64(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtss_i64(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtss_i64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_i64(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtss_i64(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtss_u64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtss_u64(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtss_u64(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtss_u64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtss_u64(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtss_u64(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtss_u64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtss_u64(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvtss_u64(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtss_u64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtss_u64(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvtss_u64(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtss_u64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtss_u64(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvtss_u64(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtss_u64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtss_u64(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtss_u64(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtss_u64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtss_u64(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvtss_u64(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtss_u64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtss_u64(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvtss_u64(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtsd_u64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtsd_u64(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtsd_u64(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtsd_u64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtsd_u64(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_u64(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtsd_u64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtsd_u64(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvtsd_u64(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtsd_u64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtsd_u64(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvtsd_u64(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtsd_u64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtsd_u64(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvtsd_u64(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtsd_u64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtsd_u64(create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_u64(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtsd_u64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtsd_u64(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvtsd_u64(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtsd_u64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtsd_u64(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvtsd_u64(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvti64_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvti64_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cvti64_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti64_ss(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvti64_ss_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvti64_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cvti64_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti64_ss(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvti64_ss_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvti64_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1i64));
        check_float_array_equality(&result, &[1.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cvti64_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti64_ss(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvti64_ss_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvti64_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1i64));
        check_float_array_equality(&result, &[1.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cvti64_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti64_ss(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvti64_ss_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvti64_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1i64));
        check_float_array_equality(&result, &[1.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cvti64_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti64_ss(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvti64_ss_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvti64_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1i64));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cvti64_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti64_ss(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvti64_ss_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvti64_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1i64));
        check_float_array_equality(&result, &[1.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cvti64_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti64_ss(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvti64_ss_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvti64_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1i64));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cvti64_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti64_ss(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvti64_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvti64_sd(create__m128d_from([1.0, 2.0]), 3i64));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| format!("{e} | call: _mm_cvti64_sd(create__m128d_from([1.0, 2.0]), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvti64_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvti64_sd(create__m128d_from([0.0f64, -1.0f64]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.0]).map_err(|e| format!("{e} | call: _mm_cvti64_sd(create__m128d_from([0.0f64, -1.0f64]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvti64_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvti64_sd(create__m128d_from([100.0f64, 200.0f64]), 1i64));
        check_float_array_equality(&result, &[1.0, 200.0]).map_err(|e| format!("{e} | call: _mm_cvti64_sd(create__m128d_from([100.0f64, 200.0f64]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvti64_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvti64_sd(create__m128d_from([f64::MIN, f64::MIN]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cvti64_sd(create__m128d_from([f64::MIN, f64::MIN]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvti64_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvti64_sd(create__m128d_from([f64::MAX, f64::MAX]), 1i64));
        check_float_array_equality(&result, &[1.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cvti64_sd(create__m128d_from([f64::MAX, f64::MAX]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvti64_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvti64_sd(create__m128d_from([0.0, 0.0]), 1i64));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cvti64_sd(create__m128d_from([0.0, 0.0]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvti64_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvti64_sd(create__m128d_from([f64::NAN, f64::NAN]), 1i64));
        check_float_array_equality(&result, &[1.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cvti64_sd(create__m128d_from([f64::NAN, f64::NAN]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvti64_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvti64_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1i64));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cvti64_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtu64_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtu64_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5u64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cvtu64_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu64_ss(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtu64_ss_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtu64_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1u64));
        check_float_array_equality(&result, &[1.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cvtu64_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu64_ss(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtu64_ss_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtu64_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1u64));
        check_float_array_equality(&result, &[1.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cvtu64_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu64_ss(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtu64_ss_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtu64_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1u64));
        check_float_array_equality(&result, &[1.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cvtu64_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu64_ss(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtu64_ss_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtu64_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1u64));
        check_float_array_equality(&result, &[1.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cvtu64_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu64_ss(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtu64_ss_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtu64_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1u64));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cvtu64_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu64_ss(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtu64_ss_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtu64_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1u64));
        check_float_array_equality(&result, &[1.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cvtu64_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu64_ss(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtu64_ss_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtu64_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1u64));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cvtu64_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu64_ss(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtu64_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtu64_sd(create__m128d_from([1.0, 2.0]), 3u64));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| format!("{e} | call: _mm_cvtu64_sd(create__m128d_from([1.0, 2.0]), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu64_sd(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtu64_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtu64_sd(create__m128d_from([0.0f64, -1.0f64]), 1u64));
        check_float_array_equality(&result, &[1.0, -1.0]).map_err(|e| format!("{e} | call: _mm_cvtu64_sd(create__m128d_from([0.0f64, -1.0f64]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu64_sd(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtu64_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtu64_sd(create__m128d_from([100.0f64, 200.0f64]), 1u64));
        check_float_array_equality(&result, &[1.0, 200.0]).map_err(|e| format!("{e} | call: _mm_cvtu64_sd(create__m128d_from([100.0f64, 200.0f64]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu64_sd(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtu64_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtu64_sd(create__m128d_from([f64::MIN, f64::MIN]), 1u64));
        check_float_array_equality(&result, &[1.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cvtu64_sd(create__m128d_from([f64::MIN, f64::MIN]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu64_sd(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtu64_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtu64_sd(create__m128d_from([f64::MAX, f64::MAX]), 1u64));
        check_float_array_equality(&result, &[1.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cvtu64_sd(create__m128d_from([f64::MAX, f64::MAX]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu64_sd(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtu64_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtu64_sd(create__m128d_from([0.0, 0.0]), 1u64));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cvtu64_sd(create__m128d_from([0.0, 0.0]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu64_sd(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtu64_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtu64_sd(create__m128d_from([f64::NAN, f64::NAN]), 1u64));
        check_float_array_equality(&result, &[1.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cvtu64_sd(create__m128d_from([f64::NAN, f64::NAN]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu64_sd(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtu64_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtu64_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1u64));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cvtu64_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu64_sd(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttsd_i64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttsd_i64(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvttsd_i64(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttsd_i64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttsd_i64(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_i64(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttsd_i64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttsd_i64(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvttsd_i64(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttsd_i64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttsd_i64(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_i64(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttsd_i64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttsd_i64(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_i64(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttsd_i64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttsd_i64(create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_i64(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttsd_i64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttsd_i64(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_i64(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttsd_i64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttsd_i64(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_i64(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttsd_u64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttsd_u64(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvttsd_u64(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttsd_u64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttsd_u64(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_u64(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttsd_u64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttsd_u64(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvttsd_u64(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttsd_u64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttsd_u64(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvttsd_u64(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttsd_u64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttsd_u64(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvttsd_u64(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttsd_u64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttsd_u64(create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_u64(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttsd_u64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttsd_u64(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvttsd_u64(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttsd_u64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttsd_u64(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvttsd_u64(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttss_i64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttss_i64(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvttss_i64(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttss_i64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttss_i64(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttss_i64(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttss_i64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttss_i64(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvttss_i64(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttss_i64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttss_i64(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttss_i64(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttss_i64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttss_i64(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttss_i64(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttss_i64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttss_i64(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttss_i64(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttss_i64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttss_i64(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttss_i64(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttss_i64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttss_i64(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttss_i64(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttss_u64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttss_u64(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvttss_u64(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttss_u64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttss_u64(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttss_u64(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttss_u64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttss_u64(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvttss_u64(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttss_u64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttss_u64(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvttss_u64(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttss_u64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttss_u64(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvttss_u64(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttss_u64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttss_u64(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttss_u64(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttss_u64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttss_u64(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvttss_u64(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttss_u64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttss_u64(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvttss_u64(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<8>(create__m128d_from([1.0, 2.0]), 3i64));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundi64_sd::<8>(create__m128d_from([1.0, 2.0]), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<8>(create__m128d_from([0.0f64, -1.0f64]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundi64_sd::<8>(create__m128d_from([0.0f64, -1.0f64]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<8>(create__m128d_from([100.0f64, 200.0f64]), 1i64));
        check_float_array_equality(&result, &[1.0, 200.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundi64_sd::<8>(create__m128d_from([100.0f64, 200.0f64]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<8>(create__m128d_from([f64::MIN, f64::MIN]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cvt_roundi64_sd::<8>(create__m128d_from([f64::MIN, f64::MIN]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<8>(create__m128d_from([f64::MAX, f64::MAX]), 1i64));
        check_float_array_equality(&result, &[1.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cvt_roundi64_sd::<8>(create__m128d_from([f64::MAX, f64::MAX]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<8>(create__m128d_from([0.0, 0.0]), 1i64));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundi64_sd::<8>(create__m128d_from([0.0, 0.0]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<8>(create__m128d_from([f64::NAN, f64::NAN]), 1i64));
        check_float_array_equality(&result, &[1.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cvt_roundi64_sd::<8>(create__m128d_from([f64::NAN, f64::NAN]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1i64));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cvt_roundi64_sd::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<8>(create__m128d_from([1.0, 2.0]), 3i64));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundsi64_sd::<8>(create__m128d_from([1.0, 2.0]), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<8>(create__m128d_from([0.0f64, -1.0f64]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundsi64_sd::<8>(create__m128d_from([0.0f64, -1.0f64]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<8>(create__m128d_from([100.0f64, 200.0f64]), 1i64));
        check_float_array_equality(&result, &[1.0, 200.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundsi64_sd::<8>(create__m128d_from([100.0f64, 200.0f64]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<8>(create__m128d_from([f64::MIN, f64::MIN]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cvt_roundsi64_sd::<8>(create__m128d_from([f64::MIN, f64::MIN]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<8>(create__m128d_from([f64::MAX, f64::MAX]), 1i64));
        check_float_array_equality(&result, &[1.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cvt_roundsi64_sd::<8>(create__m128d_from([f64::MAX, f64::MAX]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<8>(create__m128d_from([0.0, 0.0]), 1i64));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundsi64_sd::<8>(create__m128d_from([0.0, 0.0]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<8>(create__m128d_from([f64::NAN, f64::NAN]), 1i64));
        check_float_array_equality(&result, &[1.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cvt_roundsi64_sd::<8>(create__m128d_from([f64::NAN, f64::NAN]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1i64));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cvt_roundsi64_sd::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundi64_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi64_ss::<8>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundi64_ss::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi64_ss::<8>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1i64));
        check_float_array_equality(&result, &[1.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundi64_ss::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi64_ss::<8>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1i64));
        check_float_array_equality(&result, &[1.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cvt_roundi64_ss::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi64_ss::<8>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1i64));
        check_float_array_equality(&result, &[1.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cvt_roundi64_ss::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi64_ss::<8>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1i64));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundi64_ss::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi64_ss::<8>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1i64));
        check_float_array_equality(&result, &[1.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cvt_roundi64_ss::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi64_ss::<8>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1i64));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cvt_roundi64_ss::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi64_ss::<8>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<8>(create__m128d_from([1.0, 2.0]), 3u64));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundu64_sd::<8>(create__m128d_from([1.0, 2.0]), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu64_sd::<8>(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<8>(create__m128d_from([0.0f64, -1.0f64]), 1u64));
        check_float_array_equality(&result, &[1.0, -1.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundu64_sd::<8>(create__m128d_from([0.0f64, -1.0f64]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu64_sd::<8>(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<8>(create__m128d_from([100.0f64, 200.0f64]), 1u64));
        check_float_array_equality(&result, &[1.0, 200.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundu64_sd::<8>(create__m128d_from([100.0f64, 200.0f64]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu64_sd::<8>(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<8>(create__m128d_from([f64::MIN, f64::MIN]), 1u64));
        check_float_array_equality(&result, &[1.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cvt_roundu64_sd::<8>(create__m128d_from([f64::MIN, f64::MIN]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu64_sd::<8>(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<8>(create__m128d_from([f64::MAX, f64::MAX]), 1u64));
        check_float_array_equality(&result, &[1.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cvt_roundu64_sd::<8>(create__m128d_from([f64::MAX, f64::MAX]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu64_sd::<8>(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<8>(create__m128d_from([0.0, 0.0]), 1u64));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundu64_sd::<8>(create__m128d_from([0.0, 0.0]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu64_sd::<8>(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<8>(create__m128d_from([f64::NAN, f64::NAN]), 1u64));
        check_float_array_equality(&result, &[1.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cvt_roundu64_sd::<8>(create__m128d_from([f64::NAN, f64::NAN]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu64_sd::<8>(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1u64));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cvt_roundu64_sd::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu64_sd::<8>(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundsi64_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi64_ss::<8>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundsi64_ss::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi64_ss::<8>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1i64));
        check_float_array_equality(&result, &[1.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundsi64_ss::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi64_ss::<8>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1i64));
        check_float_array_equality(&result, &[1.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cvt_roundsi64_ss::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi64_ss::<8>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1i64));
        check_float_array_equality(&result, &[1.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cvt_roundsi64_ss::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi64_ss::<8>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1i64));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundsi64_ss::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi64_ss::<8>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1i64));
        check_float_array_equality(&result, &[1.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cvt_roundsi64_ss::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi64_ss::<8>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1i64));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cvt_roundsi64_ss::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi64_ss::<8>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5u64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundu64_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu64_ss::<8>(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1u64));
        check_float_array_equality(&result, &[1.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundu64_ss::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu64_ss::<8>(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1u64));
        check_float_array_equality(&result, &[1.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundu64_ss::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu64_ss::<8>(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1u64));
        check_float_array_equality(&result, &[1.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cvt_roundu64_ss::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu64_ss::<8>(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1u64));
        check_float_array_equality(&result, &[1.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cvt_roundu64_ss::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu64_ss::<8>(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1u64));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cvt_roundu64_ss::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu64_ss::<8>(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1u64));
        check_float_array_equality(&result, &[1.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cvt_roundu64_ss::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu64_ss::<8>(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1u64));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cvt_roundu64_ss::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu64_ss::<8>(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_si64::<8>(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_si64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<8>(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_si64::<8>(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_si64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<8>(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_si64::<8>(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_si64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<8>(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_si64::<8>(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_si64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<8>(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_si64::<8>(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_si64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<8>(create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_si64::<8>(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_si64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<8>(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_si64::<8>(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_si64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_si64::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_si64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_i64::<8>(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_i64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<8>(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_i64::<8>(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_i64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<8>(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_i64::<8>(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_i64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<8>(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_i64::<8>(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_i64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<8>(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_i64::<8>(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_i64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<8>(create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_i64::<8>(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_i64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<8>(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_i64::<8>(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_i64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_i64::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_i64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_u64::<8>(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_u64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<8>(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_u64::<8>(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_u64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<8>(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_u64::<8>(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_u64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<8>(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_u64::<8>(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_u64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<8>(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_u64::<8>(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_u64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<8>(create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_u64::<8>(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_u64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<8>(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_u64::<8>(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_u64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvt_roundsd_u64::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_u64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvt_roundss_si64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_si64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundss_si64::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_si64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvt_roundss_si64::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_si64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundss_si64::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_si64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundss_si64::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_si64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundss_si64::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_si64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundss_si64::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_si64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundss_si64::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_si64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvt_roundss_i64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_i64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundss_i64::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_i64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvt_roundss_i64::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_i64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundss_i64::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_i64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundss_i64::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_i64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundss_i64::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_i64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundss_i64::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_i64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundss_i64::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_i64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvt_roundss_u64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_u64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundss_u64::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_u64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvt_roundss_u64::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_u64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvt_roundss_u64::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_u64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvt_roundss_u64::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_u64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_roundss_u64::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_u64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvt_roundss_u64::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_u64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvt_roundss_u64::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_u64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_si64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_si64::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_si64::<8>(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_si64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_si64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_si64::<8>(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_si64::<8>(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_si64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_si64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_si64::<8>(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_si64::<8>(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_si64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_si64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_si64::<8>(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_si64::<8>(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_si64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_si64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_si64::<8>(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_si64::<8>(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_si64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_si64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_si64::<8>(create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_si64::<8>(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_si64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_si64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_si64::<8>(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_si64::<8>(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_si64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_si64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_si64::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_si64::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_si64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_i64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_i64::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_i64::<8>(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_i64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_i64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_i64::<8>(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_i64::<8>(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_i64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_i64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_i64::<8>(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_i64::<8>(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_i64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_i64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_i64::<8>(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_i64::<8>(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_i64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_i64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_i64::<8>(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_i64::<8>(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_i64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_i64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_i64::<8>(create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_i64::<8>(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_i64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_i64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_i64::<8>(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_i64::<8>(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_i64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_i64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_i64::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_i64::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_i64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_u64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_u64::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_u64::<8>(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_u64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_u64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_u64::<8>(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_u64::<8>(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_u64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_u64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_u64::<8>(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_u64::<8>(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_u64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_u64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_u64::<8>(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_u64::<8>(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_u64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_u64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_u64::<8>(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_u64::<8>(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_u64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_u64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_u64::<8>(create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_u64::<8>(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_u64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_u64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_u64::<8>(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_u64::<8>(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_u64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_u64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_u64::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvtt_roundsd_u64::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_u64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_i64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_i64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_i64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_i64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_i64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_i64::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_i64::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_i64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_i64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_i64::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_i64::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_i64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_i64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_i64::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_i64::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_i64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_i64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_i64::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_i64::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_i64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_i64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_i64::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_i64::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_i64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_i64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_i64::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_i64::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_i64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_i64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_i64::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_i64::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_i64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_si64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_si64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_si64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_si64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_si64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_si64::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_si64::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_si64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_si64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_si64::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_si64::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_si64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_si64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_si64::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_si64::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_si64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_si64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_si64::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_si64::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_si64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_si64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_si64::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_si64::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_si64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_si64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_si64::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_si64::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_si64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_si64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_si64::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_si64::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_si64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_u64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_u64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_u64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_u64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_u64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_u64::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_u64::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_u64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_u64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_u64::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_u64::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_u64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_u64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_u64::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_u64::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_u64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_u64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_u64::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_u64::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_u64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_u64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_u64::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_u64::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_u64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_u64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_u64::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_u64::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_u64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_u64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_u64::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvtt_roundss_u64::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_u64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}
